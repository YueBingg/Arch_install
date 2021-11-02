#!/bin/bash

install(){
	echo -e "\ny\n" | pacman -S base-devel
	sed -i 's/# %wheel/%wheel/g' /etc/sudoers
	echo -e "y\n" | pacman -S zsh
	sed -i 's/bash/zsh/g' /etc/passwd
}
main(){
	install
}
main
