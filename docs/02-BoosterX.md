# BoosterX（"boostx"）— 已下载到本地

Windows 10/11 性能优化工具：一键改电源计划、CPU 调度/核心停放、GPU 优先级、HAGS、Game Mode、鼠标加速度、后台服务与遥测等，定位和 PowerSettingsExplorer 同一类"把隐藏系统项摆到界面上"的工具，但走的是整套 profile 优化路线。

## 文件

| 路径 | 说明 |
|---|---|
| `BoosterX.exe` | 官方原版安装/运行包，**v2.4.2.4**，49.5 MB（51,955,096 字节） |

- 直接来源（作者 CDN）：`https://download.boosterx.org/BoosterX.exe`
- 官方网站：https://boosterx.org/ （`dl.boosterx.org` 在部分网络下 TLS 握手会失败，换 `download.boosterx.org` 即可）
- 文档：https://wiki.boosterx.org/en/boosterx/getting-started/

## 校验与体检

```
SHA256 : C1C17604C0331DF5FC3A9FC5220B2DB2BAD11D1FF25F31C5FAF7E2240808B0C2
大小   : 51,955,096 字节
版本   : 2.4.2.4（FileDescription/ProductName = BoosterX）
```

Authenticode 数字签名：**Valid（已验证签名）**
- 签名主体：`CN=IP Ksenofontov Iosif Yurievich, E=pro@boosterx.ru, L=Churapcha, C=RU`
- 签发机构：`GlobalSign GCC R45 CodeSigning CA 2020`，有效期至 2027-08-18

Windows Defender 扫描（对同副本完整扫描）：`found no threats`。

包体为 .NET 单文件自解压（含内嵌资源包），运行时会把主程序释放到用户目录，属正常行为。

## 使用要点

1. 双击运行，会先请求管理员权限（改电源/注册表/服务必须提权）。
2. 免费版覆盖大部分常用项；电源与 TweaX 深度项部分标 PRO（订阅制，中文站的"29 元/永久版/激活教程"多为第三方转售或引流，别在那些站拿包）。
3. 开优化前先让它**创建还原点 / 用自带 Backup**，出问题能一键 Revert（wiki 的 Restore boundaries 页说明了哪些项不可逆）。
4. 杀软误报是这类工具的常态（改的是系统底层项），本机实测未触发。

## 命名确认

`BoostX` 这个名字在网上对应多个不同产品（Android 音量增强 App、Chrome 音量扩展、TI MSP432 BOOSTXL 开发板库、桌面排版软件 boostX）。结合你上一个要的 PowerSettingsExplorer，我按 **BoosterX（Windows 优化工具）** 处理并下载了官方原版。如果你要的其实是另一个东西，说一声我再去拿。
