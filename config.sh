#!/bin/bash

disk=$1

config(){
	echo "Input hostname"
	read TMP
	echo ${TMP} > /etc/hostname
	while :
	do
		echo "Input root password"
		read pwd1
		echo "Input root password again"
		read pwd2
		if [ $pwd1 != $pwd2 ];then
			echo "Two input password must must be consistent"
		else
			break
		fi
	done
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc
	echo -e "en_US.UTF-8\nzh_CN.UTF-8" >> /etc/locale.conf
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo -e "127.0.0.1\tlocalehost\n::1\tlocalehost\n127.0.1.1\t$TMP.localdomain\t$TMP" > /etc/hosts
	efibootmgr -d ${disk} -p 1 -c -L 'Arch Linux' -l '\vmlinuz-linux' -u "root=${disk}2 rw initrd=\initramfs-linux.img"
	echo "Input user name"
	read USER
	useradd -m -g wheel $USER
	while :
	do
		echo "Input ${User} password"
		read pwd1
		echo "Input ${User} password again"
		read pwd2
		if [ $pwd1 != $pwd2 ];then
			echo "Two input password must must be consistent"
		else
			break
		fi
	done
	echo "Install done"
}
main(){
	config
}
main
