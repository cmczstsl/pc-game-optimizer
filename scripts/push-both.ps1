#requires -Version 5.1
<#
.SYNOPSIS
    把本地 win-tuning-kit 仓库同时发布到 GitHub 与 Gitee，并在两边创建 Release 附件。

.DESCRIPTION
    1) 用 API 在 GitHub / Gitee 创建同名仓库（已存在则复用）
    2) git push 到两边 main 分支
    3) 可选：把打包好的 zip 作为 Release 附件上传

.EXAMPLE
    .\push-both.ps1 -GitHubUser cmc -GitHubToken ghp_xxx -GiteeUser cmc -GiteeToken yyy -UploadRelease
#>
param(
    [Parameter(Mandatory = $true)][string]$GitHubUser,
    [Parameter(Mandatory = $true)][string]$GitHubToken,
    [string]$GiteeUser,
    [string]$GiteeToken,
    [string]$RepoName = 'win-tuning-kit',
    [string]$Tag = 'v1.0.0',
    [string]$ReleaseName = 'win-tuning-kit v1.0.0 (2026-11-13)',
    [string]$ReleaseNote = 'Windows 调优工具四件套归档：PowerSettingsExplorer 1.0.0.0 / BoosterX 2.4.2.4 / Wise Care 365 8.0.7 / Dism++ 10.1.1002.1B。校验值见仓库 SHA256SUMS.txt。',
    [string]$BundlePath = 'D:\DSH-Workspace\dist\win-tuning-kit_v1.0.0_2026-11-13.zip',
    [string]$RepoDir = 'D:\DSH-Workspace\dist\win-tuning-kit',
    [switch]$Private,
    [switch]$UploadRelease
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Write-Step($msg) { Write-Host "`n=== $msg" -ForegroundColor Cyan }

function Invoke-Api {
    param($Method, $Uri, $Headers = @{}, $Body = $null, $ContentType = 'application/json')
    try {
        $p = @{ Method = $Method; Uri = $Uri; Headers = $Headers; TimeoutSec = 300 }
        if ($null -ne $Body) { $p.Body = $Body; $p.ContentType = $ContentType }
        return Invoke-RestMethod @p
    } catch {
        $detail = $_.ErrorDetails.Message
        if ($detail) { Write-Host "  API 响应: $detail" -ForegroundColor Yellow }
        throw
    }
}

# ---------- 1. GitHub 仓库 ----------
Write-Step "创建/检查 GitHub 仓库 $GitHubUser/$RepoName"
$ghHeaders = @{ Authorization = "token $GitHubToken"; 'User-Agent' = 'win-tuning-kit'; Accept = 'application/vnd.github+json' }
$policy = Invoke-Api -Method Get -Uri 'https://api.github.com/user' -Headers $ghHeaders
Write-Host "  已认证为: $($policy.login)"
if ($policy.login -ne $GitHubUser) { Write-Host "  注意: token 属于 $($policy.login)，仓库将创建在该账号下" -ForegroundColor Yellow; $GitHubUser = $policy.login }

$repoBody = @{ name = $RepoName; description = 'Windows 调优工具归档：PowerSettingsExplorer / BoosterX / Wise Care 365 / Dism++'; private = [bool]$Private; has_issues = $true; has_wiki = $false } | ConvertTo-Json
try {
    $ghRepo = Invoke-Api -Method Post -Uri 'https://api.github.com/user/repos' -Headers $ghHeaders -Body $repoBody
    Write-Host "  已创建: $($ghRepo.html_url)"
} catch {
    $ghRepo = Invoke-Api -Method Get -Uri "https://api.github.com/repos/$GitHubUser/$RepoName" -Headers $ghHeaders
    Write-Host "  仓库已存在，复用: $($ghRepo.html_url)" -ForegroundColor Yellow
}

# ---------- 2. 推到 GitHub ----------
Write-Step "推送 main 到 GitHub"
Push-Location $RepoDir
try {
    git config http.postBuffer 524288000
    git config http.version HTTP/1.1
    $ghPushUrl = "https://{0}:{1}@github.com/{0}/{2}.git" -f $GitHubUser, $GitHubToken, $RepoName
    git push $ghPushUrl main --force 2>&1 | ForEach-Object { "  $_" }
    git remote remove origin 2>$null
    git remote add origin "https://github.com/$GitHubUser/$RepoName.git"
} finally { Pop-Location }

# ---------- 3. GitHub Release + 附件 ----------
if ($UploadRelease) {
    Write-Step "创建 GitHub Release $Tag 并上传附件"
    $relBody = @{ tag_name = $Tag; name = $ReleaseName; body = $ReleaseNote; draft = $false; prerelease = $false } | ConvertTo-Json
    try {
        $rel = Invoke-Api -Method Post -Uri "https://api.github.com/repos/$GitHubUser/$RepoName/releases" -Headers $ghHeaders -Body $relBody
    } catch {
        $rel = Invoke-Api -Method Get -Uri "https://api.github.com/repos/$GitHubUser/$RepoName/releases/tags/$Tag" -Headers $ghHeaders
    }
    if (Test-Path $BundlePath) {
        $fname = Split-Path $BundlePath -Leaf
        $existing = @($rel.assets | Where-Object name -eq $fname)
        if ($existing.Count -gt 0) {
            Write-Host "  附件 $fname 已存在，跳过" -ForegroundColor Yellow
        } else {
            Write-Host "  上传 $fname ($([math]::Round((Get-Item $BundlePath).Length/1MB,2)) MB) ..."
            $upHeaders = @{ Authorization = "token $GitHubToken"; 'User-Agent' = 'win-tuning-kit'; Accept = 'application/vnd.github+json' }
            $bytes = [IO.File]::ReadAllBytes($BundlePath)
            $asset = Invoke-Api -Method Post -Uri ("https://uploads.github.com/repos/{0}/{1}/releases/{2}/assets?name={3}" -f $GitHubUser, $RepoName, $rel.id, [uri]::EscapeDataString($fname)) -Headers $upHeaders -Body $bytes -ContentType 'application/zip'
            Write-Host "  完成: $($asset.browser_download_url)"
        }
    } else { Write-Host "  未找到 $BundlePath，跳过附件上传" -ForegroundColor Yellow }
}

# ---------- 4. Gitee ----------
if ($GiteeUser -and $GiteeToken) {
    Write-Step "创建/检查 Gitee 仓库 $GiteeUser/$RepoName"
    try {
        $geRepo = Invoke-Api -Method Post -Uri 'https://gitee.com/api/v5/user/repos' -Headers @{} -Body @{
            access_token = $GiteeToken; name = $RepoName; path = $RepoName; private = ([bool]$Private).ToString().ToLower()
            description = 'Windows 调优工具归档：PowerSettingsExplorer / BoosterX / Wise Care 365 / Dism++'; has_issues = 'true'; has_wiki = 'false'
        } -ContentType 'application/x-www-form-urlencoded'
        Write-Host "  已创建: $($geRepo.html_url)"
    } catch {
        Write-Host "  创建失败或已存在（继续推送）" -ForegroundColor Yellow
    }

    Write-Step "推送 main 到 Gitee"
    Push-Location $RepoDir
    try {
        $gePushUrl = "https://{0}:{1}@gitee.com/{0}/{2}.git" -f $GiteeUser, $GiteeToken, $RepoName
        git push $gePushUrl main --force 2>&1 | ForEach-Object { "  $_" }
        git remote remove gitee 2>$null
        git remote add gitee "https://gitee.com/$GiteeUser/$RepoName.git"
    } finally { Pop-Location }

    if ($UploadRelease -and (Test-Path $BundlePath)) {
        Write-Step "创建 Gitee Release 并上传附件"
        try {
            $geRel = Invoke-Api -Method Post -Uri "https://gitee.com/api/v5/repos/$GiteeUser/$RepoName/releases" -Body @{
                access_token = $GiteeToken; tag_name = $Tag; name = $ReleaseName; body = $ReleaseNote; target_commitish = 'main'; prerelease = 'false'
            } -ContentType 'application/x-www-form-urlencoded'
            Write-Host "  Release 已建: $($geRel.id)"
            $fname = Split-Path $BundlePath -Leaf
            Write-Host "  上传 $fname (Gitee 单附件上限较小，失败可忽略) ..."
            $resp = & curl.exe -s -X POST "https://gitee.com/api/v5/repos/$GiteeUser/$RepoName/releases/$($geRel.id)/attach_files" -F "access_token=$GiteeToken" -F "file=@$BundlePath" 2>&1
            Write-Host "  $resp"
        } catch {
            Write-Host "  Gitee Release 环节出错，仓库内容已推送，附件可稍后在网页补传" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "`n未提供 Gitee 凭据，跳过 Gitee。" -ForegroundColor Yellow
}

Write-Step "完成"
Push-Location $RepoDir
git remote -v
Pop-Location
