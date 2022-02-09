#!/bin/bash
echo '                 Free Script for all!                   '
echo ''
echo ''
echo '                    This is free and not for sell           '
echo '                 If you buy this you have been scammed      '
echo ''
echo ' .......................................................... '
echo '                     BBR By YOLO NET                        '
echo ''
echo ''
echo '                         Telegram @rayyolo                  '
echo ''
echo '                       Tunggu 5 Saat!                       '
echo ' .......................................................... '
sleep 5
clear
echo '============================================================'
echo '                   Sila Tunggu sebentar...                  '
echo '                 Memulakan BBR YOLONET...                   '
echo '============================================================'
sleep 2



Add_To_New_Line(){
	if [ "$(tail -n1 $1 | wc -l)" == "0"  ];then
		echo "" >> "$1"
	fi
	echo "$2" >> "$1"
}

Check_And_Add_Line(){
	if [ -z "$(cat "$1" | grep "$2")" ];then
		Add_To_New_Line "$1" "$2"
	fi
}

Install_BBR(){
echo "#############################################"
echo "Install TCP_BBR..."
if [ -n "$(lsmod | grep bbr)" ];then
echo "TCP_BBR sudah diinstall."
echo "#############################################"
return 1
fi
echo "Installing TCP_BBR..."
modprobe tcp_bbr
Add_To_New_Line "/etc/modules-load.d/modules.conf" "tcp_bbr"
Add_To_New_Line "/etc/sysctl.conf" "net.core.default_qdisc = fq"
Add_To_New_Line "/etc/sysctl.conf" "net.ipv4.tcp_congestion_control = bbr"
sysctl -p
if [ -n "$(sysctl net.ipv4.tcp_available_congestion_control | grep bbr)" ] && [ -n "$(sysctl net.ipv4.tcp_congestion_control | grep bbr)" ] && [ -n "$(lsmod | grep "tcp_bbr")" ];then
	echo "BBR berjaya di masukkan."
	sleep 2
else
	echo "TIDAK BERJAYA memasukkan BBR."
	sleep 2
fi
echo "#############################################"
}
Optimize_Parameters(){
echo "#############################################"
echo "Sedang Optimumkan Parameter..."
Check_And_Add_Line "/etc/sysctl.conf" "fs.file-max = 51200"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.arp_ignore = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.rmem_max = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.wmem_max = 67108864"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.core.netdev_max_backlog = 250000"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.somaxconn = 4096"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_syncookies = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_tw_reuse = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_tw_recycle = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fin_timeout = 30"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_time = 1200"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.ip_local_port_range = 10000 65000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_syn_backlog = 8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_frto = 0"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_tw_buckets = 5000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fastopen = 3"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_rmem = 4096 87380 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_wmem = 4096 65536 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_mtu_probing = 1"
echo "sysctl -p"
##############################
##############################
Check_And_Add_Line "/etc/security/limits.conf" "* soft nofile 51200"
Check_And_Add_Line "/etc/security/limits.conf" "* hard nofile 51200"
Check_And_Add_Line "/etc/pam.d/common-sessio" "session required pam_limits.so"
Check_And_Add_Line "/etc/profile" "ulimit -n 51200"
echo "ulimit -n 51200"
echo " Selesai Bossku."

echo "#############################################"
}
Install_BBR
Optimize_Parameters



rm -f /root/BBR-YoloNet.sh
echo '============================================================'
echo '                       Sudah selesai!                       '
echo '                 restart server bosku!                      '
echo '============================================================'
sleep 5
