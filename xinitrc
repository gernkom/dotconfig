#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

# merge in defaults and keymaps

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export http_proxy="127.0.0.1:7890"
export https_proxy=$http_proxy

# For dwm
cpu_usage()
{
    echo $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
}

today()
{
    echo $(date '+%Y %b %d (%a) %I:%M %p')
}

vol()
{
    echo $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
}

local_proxy_port()
{
    echo $(echo $http_proxy | awk -F':' '{print $2}')
}

download_speed()
{
    eth=enp5s0

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
    xsetroot -name "$(download_speed) |   $(cpu_usage) |   $(local_proxy_port) |  $(vol) |   $(today)"
done &

xset r rate 300 30
fcitx5 &
dunst &
flameshot &
telegram-desktop &
feh --bg-fill /home/gk/Pictures/bg.png
/home/gk/.config/xob/pulse-volume-watcher.py | xob -t 2000 &

exec dwm
