# Wise Care 365 v8.0.7 — 已下载到本地

Windows 系统清理与优化套件（注册表清理、磁盘垃圾清理、启动项与计划任务管理、隐私痕迹清理、系统监控与硬件信息、实时保护等）。免费版功能受限，PRO 为付费授权。

## 文件

| 路径 | 说明 |
|---|---|
| `WiseCare365_Setup.exe` | 官方安装包，**v8.0.7**（当前最新版），36.2 MB（37,902,136 字节） |

- 直链（官方 CDN）：`https://downloads.wisecleaner.com/soft/WiseCare365.exe`
- 官方站：https://www.wisecleaner.com/wise-care-365.html
- 更新日志：http://lists.wisecleaner.com/blog_sort_8_1.html

> 注意域名区别：`www.wisecleaner.com/soft/WiseCare365.exe` 会 404，实际文件只在 `downloads.wisecleaner.com` 上；`wisecleaner.com.cn` 是中文站，也能下到同一安装包。

## 校验与体检

```
SHA256 : 2B616CE24F64AB12A5088A2C1D9E1E414EA22C37B37C75FEEE0469462E1C2133
大小   : 37,902,136 字节
版本   : 8.0.7（FileDescription / ProductName = Wise Care 365）
公司   : WiseCleaner Technology Co., Ltd.
```

Authenticode 数字签名：**Valid（已验证签名），EV 代码签名证书**
- 签名主体：`CN="WiseCleaner Technology Co., Ltd.", L=Kunming, S=Yunnan, C=CN`（企业实名信息已入证书）
- 签发机构：`GlobalSign GCC R45 EV CodeSigning CA 2020`，有效期至 2027-05-09
- EV 证书意味着 SmartScreen 直接信任，安装时不弹「未知发布者」警告 —— 反过来，如果下载到的包提示未知发布者，那就是被改包的

Windows Defender 扫描（同副本完整扫描）：`found no threats`。

## 安装与使用要点

1. 双击安装；建议安装向导里留意每一步的可选项，推广/推荐组件一律不勾。
2. 免费版即可用清理、优化、启动项管理；PRO 解锁实时保护、深度清理、自动维护等。
3. 注册表清理类操作前先建还原点（程序内提供备份中心，也可手动 `创建系统还原点`）。
4. 中文站的「绿色破解版 / 永久激活码」都是二次打包或改注册表激活的，签名必然失效；本目录的包签名有效、来自官方 CDN。
