# !/bin/bash
partion_format(){
	fdisk -l
	echo "Partition input the disk (/dev/sdx"
	read TMP
	echo -e "g\nn\n\n\n+500M\nn\n\n\n\n\nt\n1\n1\nw\n" fdisk $TMP 1>/dev/null 2>&1
	sleep 1
	echo "Partition done"
	mkfs.fat -F32 ${TMP}1 1>/dev/null 1>&2
	mkfs.ext4 ${TMP}2 1>/dev/null 1>&2
	echo "FAT32 EXT4 done"
}
install_config(){
	mount /dev/sda2 /mnt
#	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
#	pacstrap /mnt base linux linux-firmware	--force
#	pacman -Syy
    genfstab -U -p /mnt >> /mnt/etc/fstab
	arch-chroot /mnt
	echo "Input hostname"
	read TMP
	echo TMP > /etc/hostname
	while :
	do
		echo "Input root password"
		read pwd1
		echo "Input root password again"
		read pwd2
		if [ $pwd1 != $pw2 ];then
			echo "Two input password must must be consistent"
		else
			break
		fi
	done
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc
	echo -e "en_US.UTF-8\nzh_CN.UTF-8" > /etc/locale.conf
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	echo -e "127.0.0.1\tlocalehost\n::1\tlocalehost\n127.0.1.1\t$TMP.localdomain\t$TMP" >> /etc/hosts
}
main(){
	install_config
}
main
