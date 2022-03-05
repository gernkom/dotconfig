# GNU/Linux 系统配置文件

![效果图 - 1](screenshot/1.png)
![效果图 - 2](screenshot/2.png)

# 详细配置

1. 窗口管理器为魔改版 [dwm](./dwm)，该版本使用了两个补丁：[systray](https://dwm.suckless.org/patches/systray) 以及 [uselessgap](https://dwm.suckless.org/patches/uselessgap)
2. 程序起动器为魔改版 [dmenu](./dmenu)
3. 使用 [fontconfig](./fontconfig) 将全局字体设置为 [Sarasa Gothic / 更纱黑体](https://github.com/be5invis/Sarasa-Gothic)，`dwm` 及 `dmenu` 的字体通过 [config.def.h](./dwm/config.def.h#L14#L15) 进行配置。
4. 终端模拟器为 [Alacritty](https://github.com/alacritty/alacritty)
5. 中文输入法框架为 `fcitx5`，输入法引擎为 `rime`
6. 可视化系统通知使用 `dunst`
7. 可视化音量调节使用 [xob](https://github.com/florentc/xob) 实现
