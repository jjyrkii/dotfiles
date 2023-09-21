#!/bin/bash
cd /home/tim/ || exit

echo "--- installing via apt ---"
packages=("zsh" "build-essential" "cmake" "ninja-build" "gettext" "unzip" "zsh" "nodejs")

for i in "${packages[@]}"; do
	if ! [ -x "$(command -v $i)" ]; then
    		echo "--- installing $i ---"
		sudo apt -y install $i
  	else
    		echo "--- $i already installed --- "
  	fi
done

echo "--- installing rust ---"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "--- installing golang---"
wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
rm -rf go1.21.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

if ! [ -x "$(command -v nvim)" ]; then
	echo "--- installing neovim ---"
	git clone https://github.com/neovim/neovim
	cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
	cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
	rm -rf /home/tim/neovim
else
	echo "--- neovim already installed --- "
fi

if ! [ -d "/home/tim/.oh-my-zsh" ]; then
	echo "--- installing oh-my-zsh ---"

	chsh -s /usr/bin/zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "--- oh-my-zsh already installed --- "
fi

echo "--- installing astronvim dependencies ---"
cargo install tree-sitter-cli ripgrep bottom --locked 
go install github.com/jesseduffield/lazygit@latest 
go install github.com/dundee/gdu/v5/cmd/gdu@latest

echo "--- creating config ---"
home=(
	".gitconfig"
	".zshrc"
)

for i in "${home[@]}"; do
	rm -rf /home/tim/"${i}"
	ln -s /home/tim/.dotfiles/home/"${i}" /home/tim/
done

if ! [ -d "/home/tim/.config" ]; then
	mkdir /home/tim/.config
fi

config=(
	"nvim"
)

for i in "${config[@]}"; do
	rm -rf /home/tim/.config/"${i}"
	ln -s /home/tim/.dotfiles/config/"${i}" /home/tim/.config/
done
"--- config created ---"
"--- SETUP DONE ---"
