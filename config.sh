config(){
	echo "Input hostname"
	read TMP
	echo TMP > /etc/hostname
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
}
main(){
	config
}
main
