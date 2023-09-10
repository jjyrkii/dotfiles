#!/bin/bash
cd /home/tim/

home=(
  ".gitconfig"
)

for i in ${home[@]}
do
  ln -s /home/tim/dotfiles/home/${i} /home/tim/
done

ln -s /home/tim/dotfiles/nvim /home/tim/.config/nvim/lua/user
