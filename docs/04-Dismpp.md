# Dism++ 10.1.1002.1B — 已下载到本地

Chuyu Team 开源出品的 Windows 部署镜像（DISM）与系统管理前端工具：系统更新清理（WinSxS 组件清理）、CompactOS 压缩、驱动导出/导入、无人值守应答文件、离线系统修复、启动项与更新管理、系统优化与隐私设置。免安装绿色版。

## 文件

| 路径 | 说明 |
|---|---|
| `Dism++10.1.1002.1B.zip` | 官方 release 原始包（3.59 MB / 3,767,974 字节） |
| `Dism++10.1.1002.1B\` | 已解压的完整程序目录 |

解压后关键文件：

| 文件 | 说明 |
|---|---|
| `Dism++10.1.1002.1B\Dism++x64.exe` | 主程序（64 位系统用这个） |
| `Dism++10.1.1002.1B\Dism++x86.exe` | 32 位系统用 |
| `Dism++10.1.1002.1B\Dism++ARM64.exe` | ARM64 设备用 |
| `Config\Languages\zh-Hans.zip` | 简体中文语言包 |
| `Config\amd64\wimgapi.dll`、`wofadk.sys` | 映像处理与 WOF 压缩驱动 |
| `Config\Plugins\FrogPlugins_*\Plugin.amd64.dll` | 清理规则插件 |

- 官方仓库：https://github.com/Chuyu-Team/Dism-Multi-language
- Release 页：https://github.com/Chuyu-Team/Dism-Multi-language/releases/tag/v10.1.1002.2
- 官方论坛：http://www.chuyu.me

> 本次下载提示：GitHub 直链（objects.githubusercontent.com）在当前网络被重置，最终经 `gh-proxy.com` 镜像拉取同一 URL。落地大小与 GitHub API 报告的 asset 大小完全一致（3,767,974 字节）。

## 校验与体检

```
Dism++10.1.1002.1B.zip  SHA256 : 5BBAB96D60704854EFD8246A7D9371688B9102261544827FC8884126D70BCB3B
大小 : 3,767,974 字节（与 GitHub API asset size 一致）
版本 : 10.1.1002.1（内部版本 B，2023-03-26 发布）
公司 : Chuyu Team，版权 © Chuyu
```

- 数字签名：**未签名（NotSigned）** —— 这是 Dism++ 的一贯状态，作者从未给 exe 上证书。也就是说，「签名无效」不能作为判断被改包的依据，判断真伪只能靠「来源 URL + 包体大小 + SHA256」三件套（上面的值已记录，可随时复核）。
- 清单：`requestedExecutionLevel level="requireAdministrator"` —— 启动必弹 UAC，正常，它要操作 DISM/WIM/服务。
- Windows Defender 扫描整目录：`found no threats`。

## 使用要点

1. 直接双击 `Dism++x64.exe`（免安装，绿色版，配置写在同目录 `Config` 下，可整个目录拷到 U 盘随身带）。
2. 首次启动会自动释放 `Config\Languages` 里的语言包，选简体中文。
3. 常用入口：
   - `空间回收` → WinSxS 组件清理、Windows 更新缓存、驱动残留（清理前先看每项描述，别一把全勾）
   - `工具箱` → CompactOS、启动项管理、引导修复、系统还原
   - `控制面板` → 系统优化、隐私安全（遥测、Cortana、OneDrive 等开关）
   - `驱动管理` → 导出本机驱动，重装系统前必做
4. 离线扫描系统更新需要额外的 `wsusscn3.cab`（约 96 MB），不在本次包里，需要的话从上一版 Release 的 asset 取：`v10.1.1002.1\wsusscn3_476c45753d48d180f41138fd4031b2b3.cab`。
5. 清理 WinSxS 后**无法回滚已装的更新**，操作前建议先建系统还原点。
