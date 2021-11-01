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
install(){
	mount /dev/sda2 /mnt
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
	pacstrap /mnt base linux linux-firmware	--force
	pacman -Syy
	genfstab -U /mnt > /mnt/etc/fstab
	cp config.sh /mnt/root/
	chmod +x config.sh
	arch-chroot /mnt /root/config.sh
}
main(){
	install
}
main
