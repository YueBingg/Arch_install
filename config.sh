#!/bin/bash

disk=$1

config(){
	echo "Input hostname"
	read TMP
	echo ${TMP} > /etc/hostname
	echo "Change root password"
	passwd
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc
	echo -e "en_US.UTF-8\nzh_CN.UTF-8" >> /etc/locale.conf
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo -e "127.0.0.1\tlocalehost\n::1\tlocalehost\n127.0.1.1\t$TMP.localdomain\t$TMP" > /etc/hosts
	echo "Input user name"
	read USER
	useradd -m -g wheel $USER
	passwd $USER
	efibootmgr -d ${disk} -p 1 -c -L 'Arch Linux' -l '\vmlinuz-linux' -u "root=${disk}2 rw initrd=\initramfs-linux.img"
	echo "Install done"
}
install(){
	echo -e "y\n" pacman -S sudo
	sed -i 's/# %wheel/%wheel/g' /etc/sudoers
	pacman -S zsh
	sed -i 's/bash/zsh/g' /etc/passwd
}
main(){
	config
}
main
