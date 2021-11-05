#!/bin/bash

# 获取下行速度
# 依赖于 ifstat grep awk
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
    xsetroot -name "\uf300: $(download_speed)"
    sleep 1
done
