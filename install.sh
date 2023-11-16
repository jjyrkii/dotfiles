#!/bin/bash
DIR="$(pwd)"
cd "$HOME" || exit

echo "--- updating system ---"
sudo rm -rf /etc/pacman.conf
sudo ln -s "$DIR/etc/pacman.conf" /etc/
sudo pacman -Syyu --noconfirm --needed

packages=(
	"zsh"
	"base-devel"
	"zsh"
	"nodejs"
	"neovim"
	"github-cli"
	"go"
	"google-chrome"
	"npm"
)

for i in "${packages[@]}"; do
	if ! [ -x "$(command -v "${i:?}")" ]; then
		echo "--- installing ${i:?} ---"
		yay -S "${i:?}" --noconfirm --needed
	else
		echo "--- ${i:?} already installed --- "
	fi
done

if ! [ -x "$(command -v cargo)" ]; then
	echo "--- installing rust ---"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
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

echo "--- installing astrovim ---"
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

echo "--- creating config ---"
etc=(
	"pacman.conf"
)
for i in "${etc[@]}"; do
	sudo rm -rf /etc/"${i:?}"
	sudo ln -s "$DIR/etc/${i:?}" /etc/
done

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
