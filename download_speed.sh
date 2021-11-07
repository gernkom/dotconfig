#!/bin/bash

# 获取下行速度
# 依赖于 ifstat
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

# 不依赖于现成网络工具
download_speed2()
{
    # 网卡接口
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
    echo "$(download_speed2)"
done
