# 电脑游戏优化软件

电脑游戏优化软件 —— Windows 系统调优 / 清理工具归档。四个工具，全部为官方原版，逐个核对过来源、大小与 SHA256。

整理日期：2026-11-13　|　总大小：89.5 MB

## 工具清单

| # | 工具 | 版本 | 文件 | 大小 | 用途 | SHA256 |
|---|---|---|---|---|---|---|
| 01 | PowerSettingsExplorer | 1.0.0.0 (+ alt 0.2.0) | `packages/PowerSettingsExplorer_v1.0.0.0.zip` | 233 KB | 解锁 Windows 全部隐藏电源选项（处理器性能提升模式、核心停放、EPP、异类线程调度等） | `45B1939DDDCE9FC7DFAC5EC8D79D52346C13544FCBD4ACAD36E43DD74530B1E3` |
| 02 | BoosterX | 2.4.2.4 | `packages/BoosterX_v2.4.2.4_Setup.exe` | 49.55 MB | 游戏性能优化：电源计划、CPU 调度、GPU 优先级、HAGS、Game Mode、后台服务 | `C1C17604C0331DF5FC3A9FC5220B2DB2BAD11D1FF25F31C5FAF7E2240808B0C2` |
| 03 | Wise Care 365 | 8.0.7 | `packages/WiseCare365_v8.0.7_Setup.exe` | 36.15 MB | 系统清理与优化：注册表、磁盘垃圾、启动项、隐私痕迹、实时保护 | `2B616CE24F64AB12A5088A2C1D9E1E414EA22C37B37C75FEEE0469462E1C2133` |
| 04 | Dism++ | 10.1.1002.1B | `packages/Dism++_v10.1.1002.1B.zip` | 3.59 MB | 系统映像与更新管理：WinSxS 清理、CompactOS、驱动导出、离线修复、系统优化 | `5BBAB96D60704854EFD8246A7D9371688B9102261544827FC8884126D70BCB3B` |

## 详细说明

每个工具的来源、官方链接、校验值、签名状态与使用要点见 `docs/`：

- [docs/01-PowerSettingsExplorer.md](docs/01-PowerSettingsExplorer.md)
- [docs/02-BoosterX.md](docs/02-BoosterX.md)
- [docs/03-WiseCare365.md](docs/03-WiseCare365.md)
- [docs/04-Dismpp.md](docs/04-Dismpp.md)

## 来源与签名状态

| 工具 | 下载源 | 数字签名 |
|---|---|---|
| PowerSettingsExplorer | GitHub `kafuuchino-nene/PowerSettingsExplorer`（社区镜像） | 无（.NET 小工具，未签名） |
| BoosterX | 官方 CDN `download.boosterx.org/BoosterX.exe` | **Valid** — `IP Ksenofontov Iosif Yurievich`，GlobalSign R45 |
| Wise Care 365 | 官方 CDN `downloads.wisecleaner.com/soft/WiseCare365.exe` | **Valid** — `WiseCleaner Technology Co., Ltd.`，GlobalSign R45 **EV** |
| Dism++ | GitHub `Chuyu-Team/Dism-Multi-language` Release `v10.1.1002.2` | 无（作者素来不签 exe） |

## 校验方法

```powershell
# Windows PowerShell
Get-FileHash .\packages\* -Algorithm SHA256 | Select-Object Hash, Path

# 逐个比对
Get-Content .\SHA256SUMS.txt
```

```bash
# Linux / macOS
sha256sum -c SHA256SUMS.txt
```

## 备注

1. 免安装工具（PowerSettingsExplorer、Dism++）解压即用；BoosterX 与 Wise Care 365 为安装包。
2. 需要改系统设置的三个都要管理员权限。改动前先建系统还原点 / 用程序自带备份。
3. Dism++ 离线更新扫描另需 `wsusscn3.cab`（约 96 MB），不在本归档内，可从其 `v10.1.1002.1` Release 的 asset 取。
