# PowerSettingsExplorer（PSE）— 已下载到本地

Windows 电源设置解锁工具：把 `powercfg` 里默认隐藏的全部高级电源选项（处理器性能提升模式、核心停放、EPP、异类线程调度、PCIe 链路电源管理、USB 选择性暂停等）可视化列出来，可显示/隐藏、改 AC/DC 数值、导出 `.pow` 方案、生成批处理脚本。

## 目录内容

| 路径 | 说明 |
|---|---|
| `classic\PowerSettingsExplorer.exe` | 经典版 1.0.0.0（.NET Framework 4.5.1，2017），社区流传最广的版本，已验证可正常启动（窗口标题 PowerSettingsExplorer） |
| `classic\PowerSettingsExplorer.exe.config` | 配套配置（可加 `bg`/`fg`/`dc` 键切深色主题） |
| `alt\power-settings-explorer.exe` | WtekSupport 重写版 v0.2.0（原生编译，非 .NET，支持 EN/RU，Win10/11 适配更新） |
| `PowerSettingsExplorer-source-zip.zip` | 经典版原始压缩包，保留作来源凭证 |

## 校验值（SHA256）

```
B2094D475BED243A6315965728AF3D01890EEA18BEF3440F9202070400A0B902  classic\PowerSettingsExplorer.exe
9F600282B088ACF56B1752D9946643B429943FA805527AF8CBA82F011BBF54CC  classic\PowerSettingsExplorer.exe.config
EA980776B9434F8956787BE6EEE3FD263BFEE87C99A1736B57F68E4B4DFC6E1A  alt\power-settings-explorer.exe
AA61144604263969E0210349ACE60B688B8AFBF26CF6FF7FD21A5FF3985BED3E  PowerSettingsExplorer-source-zip.zip
```

## 安全体检结果

- Windows Defender 全目录扫描：`found no threats`。
- 经典版为 .NET 程序，字符串检查：无 `System.Net` / `WebClient` / `WebRequest` / `DownloadString` / `cmd.exe` / `FromBase64` / `Assembly.Load` 等联网或执行外链的行为，只有电源相关 API 与 UI 逻辑。
- 经典版清单为 `asInvoker`：不会自动弹 UAC，**修改设置前需自己右键「以管理员身份运行」**，否则只能看不能改。

## 使用要点

1. 右键 → 以管理员身份运行。
2. 改之前先 `File → Export` 导出当前方案 `.pow` 备份。
3. 改完点 `Apply`。
4. 调崩了：`powercfg -restoredefaultschemes`（管理员命令行），或重新选「平衡/高性能」计划覆盖。

## 来源

- 经典版（社区镜像仓库，国内教程普遍引用）：https://github.com/kafuuchino-nene/PowerSettingsExplorer
- 重写版（EN/RU、Win10/11）：https://github.com/WtekSupport/PowerSettingsExplorer/releases

> 注：搜索到的大量「Power Settings Explorer 下载安装教程（附安装包）」中文站点多为 SEO 引流页，下载最终会跳到 54benniao / 夸克网盘等第三方网盘，不是作者发布渠道；本目录内文件均取自 GitHub 仓库与 Release，未使用这些网盘包。
