#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export http_proxy="127.0.0.1:7890"
export https_proxy=$http_proxy

# For dwm
download_speed()
{
    # 网卡接口
    eth=enp6s0

    pre_rx=$(cat /proc/net/dev | grep $eth | awk -F' ' '{print $2}')
    sleep 1
    rx=$(cat /proc/net/dev | grep $eth | awk -F' ' '{print $2}')
    rx=$((${rx} - ${pre_rx}))

    if [[ $rx -lt 1024 ]]; then
	rx="${rx}B/s"
    elif [[ $rx -gt 1048576 ]]; then
	rx=`awk 'BEGIN{printf "%.2fM/s", '$rx' / 1048576}'`
    else
	rx=`awk 'BEGIN{printf "%.2fK/s", '$rx' / 1024}'`
    fi

    echo $rx
}


while true; do
    xsetroot -name "$(download_speed)"
    sleep 1
done &

picom &
fcitx5 &
dunst &
flameshot &
telegram-desktop &
feh --bg-fill /home/gk/Pictures/bg.png

exec dwm
