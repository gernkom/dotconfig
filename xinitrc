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

# For dwm
download_speed()
{
    download_speed=`ifstat | grep enp5s0 | awk -F' ' '{print $6}'`
    re='^[0-9]+$'
    if ! [[ $download_speed =~ $re ]] ; then
	download_speed=${download_speed%?}
	download_speed=`awk 'BEGIN{printf "%.2fM/s\n", '$download_speed' / 1024}'`
    else
	download_speed=`awk 'BEGIN{printf "%.2fK/s\n", '$download_speed' / 1024}'`
    fi
    echo $download_speed
}
while true; do
    xsetroot -name "Net: $(download_speed)"
    sleep 1
done &

fcitx5 &
dunst &
flameshot &
telegram-desktop &
feh --bg-fill /home/gk/Pictures/wallhaven-q2ogyr.png

exec dwm
