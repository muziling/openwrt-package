#!/bin/bash
# random cloudflare anycast ip
testSpeed()
{
    local domain=$1
    local file=$2
    local testip=$3
    curl --resolve $domain:443:$testip https://$domain/$file -o /dev/null --connect-timeout 5 --max-time 15 > /tmp/mycfip/log.txt 2>&1
    local avg=$(cat /tmp/mycfip/log.txt | tr '\r' '\n' |grep '0:00:'| awk '{print $7}'|sed -n '$p')
    local speedunit=${avg: -1}
    if [ ${speedunit} == 'k' ]; then
        echo $(expr ${avg%?}*1024)
    elif [ ${speedunit} == 'M' ]; then
        echo $(expr ${avg%?}*1024*1024)
    else
        echo $avg
    fi
    return $?
}

findbestip()
{
    local domain=$1
    local file=$2
    local speed=$3
    declare -i findtimes
    findtimes=0
    starttime=`date +'%Y-%m-%d %H:%M:%S'`
    anycast=''
    declare -i max
    while true
    do
        findtimes+=1
        if [ $findtimes -gt 20 ]
        then
            break
        fi
        declare -i n
        declare -i count
        rm -rf /tmp/mycfip/*
        # echo 生成随机IP
        n=0
        count=$(($RANDOM%5))
        for i in `cat data.txt | sed '1,7d'`
        do
            if [ $n -eq $count ]
            then
                randomip=$(($RANDOM%256))
                echo $i$randomip>>/tmp/mycfip/ip.txt
                count+=4
            else
                n+=1
            fi
        done
        n=0
        m=$(cat /tmp/mycfip/ip.txt | wc -l)
        count=$(expr $m / 30 + 1)
        fping -f /tmp/mycfip/ip.txt -c $count -i 1 2> /tmp/mycfip/fping1.txt 1>/dev/null
        grep min /tmp/mycfip/fping1.txt > /tmp/mycfip/fping.txt
        sort -t/ -k 5n /tmp/mycfip/fping.txt | cut -f 1 -d: | sed '31,$d' > /tmp/mycfip/ip.txt
        # echo 选取30个丢包率最少的IP地址下载测速
        mkdir /tmp/mycfip/temp
        for i in `cat /tmp/mycfip/ip.txt`
        do
            curl --resolve $domain:443:$i https://$domain/$file -o /tmp/mycfip/temp/$i -s --connect-timeout 2 --max-time 10 &
        done
        # echo 等待测速进程结束,筛选出三个优选的IP
        sleep 15
        # echo 测速完成
        ls -S /tmp/mycfip/temp > /tmp/mycfip/ip.txt
        n=$(wc -l /tmp/mycfip/ip.txt | awk '{print $1}')
        if [ $n -ge 3 ]; then
            first=$(sed -n '1p' /tmp/mycfip/ip.txt)
            second=$(sed -n '2p' /tmp/mycfip/ip.txt)
            third=$(sed -n '3p' /tmp/mycfip/ip.txt)
            # echo 优选的IP地址为 $first - $second - $third
            # echo 测试第1个优选IP $first
            max=$(testSpeed $domain $file $first)
            # echo 平均速度 $[$max/1024] kB/s
            if [ $max -ge $speed ]; then
                anycast=$first
                break
            fi
    
            # echo 测试第2个优选IP $second
            max=$(testSpeed $domain $file $second)
            # echo 平均速度 $[$max/1024] kB/s
            if [ $max -ge $speed ]; then
                anycast=$second
                break
            fi
    
            # echo 测试第3个优选IP $third
            max=$(testSpeed $domain $file $third)
            # echo 平均速度 $[$max/1024] kB/s
            if [ $max -ge $speed ]; then
                anycast=$third
                break
            fi
        fi
    done
    endtime=`date +'%Y-%m-%d %H:%M:%S'`
    start_seconds=$(date --date="$starttime" +%s)
    end_seconds=$(date --date="$endtime" +%s)
    # echo 优选IP $anycast 满足 $[$speed/1024] KB带宽需求
    # echo 平均速度 $[$max/1024] kB/s
    # echo 总计用时 $((end_seconds-start_seconds)) 秒
    echo $anycast
    return $?
}

mkdir -p /tmp/mycfip
datafile="./data.txt"
if [[ ! -f "$datafile" ]]
then
    echo 获取CF节点IP
    curl --retry 3 https://update.udpfile.com -o data.txt -#
fi
domain=$(cat data.txt | grep domain= | cut -f 2- -d'=')
file=$(cat data.txt | grep file= | cut -f 2- -d'=')
declare -i speed
if [ ! -z "$1" -a "$1" != "" ]
then
    if [[ $1 =~ "." ]]
    then
        echo 开始测试$1的速度
        declare -i testipspeed
        testipspeed=$(testSpeed $domain $file $1)
        echo 平均速度为 $[$testipspeed/1024] kB/s
        echo $[$testipspeed/1024]
    else
        speed=$(expr $1*1024)
        echo 期望到 CloudFlare 服务器的速度为 $1 KB
        echo "$(findbestip $domain $file $speed)"
    fi
else
    declare -i bandwidth
    read -p "请设置期望到 CloudFlare 服务器的速度(单位 KB):" bandwidth
    speed=bandwidth*1024
    echo $(findbestip $domain $file $1)
fi
rm -rf /tmp/mycfip/*
