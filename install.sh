#!/bin/bash
DIR="$(pwd)"
cd "$HOME" || exit

echo "--- updating system ---"
sudo dnf upgrade -y

packages=(
	"zsh"
	"make"
	"automake"
	"gcc"
	"gcc-c++"
	"kernel-devel"
	"zsh"
	"nodejs"
	"neovim"
	"gh"
	"go"
	"google-chrome-unstable"
)

for i in "${packages[@]}"; do
	if ! [ -x "$(command -v "${i:?}")" ]; then
		echo "--- installing ${i:?} ---"
		sudo dnf install "${i:?}" -y
	else
		echo "--- ${i:?} already installed --- "
	fi
done

if ! [ -x "$(command -v cargo)" ]; then
	echo "--- installing rust ---"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
else
	echo "--- rust already installed --- "
fi

if ! [ -d "$HOME/.oh-my-zsh" ]; then
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

if ! [ -d "/usr/local/share/fonts/JetBrainsMono" ]; then
	sudo mkdir "/usr/local/share/fonts"
fi
if ! [ -d "/usr/local/share/fonts/JetBrainsMono" ]; then
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
	sudo unzip JetBrainsMono.zip -d "/usr/local/share/fonts/JetBrainsMono"
	rm -rf JetBrainsMono.zip
fi

echo "--- installing astrovim ---"
rm -rf "$HOME/.config/nvim"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$HOME/.config/nvim"

echo "--- creating config ---"
home=(
	".gitconfig"
	".zshrc"
	".config/nvim/lua/user"
)
for i in "${home[@]}"; do
	rm -rf "$HOME/${i:?}"
	ln -s "$DIR/home/${i:?}" "$HOME/${i:?}"
done
echo "--- config created ---"

echo "--- SETUP DONE ---"
