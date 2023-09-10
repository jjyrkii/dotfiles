#!/bin/bash
cd /home/tim/ || exit

home=(
	".gitconfig"
	".zshrc"
)

for i in "${home[@]}"; do
	ln -s /home/tim/.dotfiles/home/"${i}" /home/tim/
done

config=(
	"nvim"
)
for i in "${config[@]}"; do
	ln -s /home/tim/.dotfiles/config/"${i}" /home/tim/.config/
done
