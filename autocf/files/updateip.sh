#!/bin/bash
# auto update xray cloudflare
# run bash updateip.sh 500
cd /etc/autocf
declare -i minspeed
declare -i currentspeedkb
minspeed=$1
currentspeedkb=0
currentip=$(grep address /root/xray.cf.json|grep -v '8.8.'|awk -F\" '{print $4}')
if [ "$currentip" != "" ]
then
    echo 开始测试$currentip的速度
    sudo -u proxy bash cf.sh $currentip > /tmp/cfip.speed
    currentspeedkb=$(cat /tmp/cfip.speed|sed -n '$p')
    echo $(date '+%Y-%m-%d %H:%M')当前IP${currentip}速度${currentspeedkb} >> /tmp/cfipchange.log
    if [ ${currentspeedkb} -lt 10 ]
    then
        echo 开始二次测试$currentip的速度
        sudo -u proxy bash cf.sh $currentip > /tmp/cfip.speed
        currentspeedkb=$(cat /tmp/cfip.speed|sed -n '$p')
        echo $(date '+%Y-%m-%d %H:%M')当前IP${currentip}速度${currentspeedkb} >> /tmp/cfipchange.log
    fi
fi
if [ ${currentspeedkb} -lt ${minspeed} ]
then
    sudo -u proxy bash cf.sh $minspeed >/tmp/cfip.speed
    newip=$(cat /tmp/cfip.speed|sed -n '$p')
	echo $newip >> /tmp/cfipchange.log
	cat /tmp/cfip.speed
	if [ "$newip" != "" ]
	then
		echo $(date '+%Y-%m-%d %H:%M')找到新地址：$newip，即将修改xray配置 >> /tmp/cfipchange.log
		sed -i "s/$currentip/$newip/" /root/xray.cf.json
		ss-tproxy restart
	fi
fi
#rm -f /tmp/cfip.speed