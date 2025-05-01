#!/bin/bash

install_font() {
  temp_dir=$(mktemp -d)
  wget -O "$temp_dir/font.zip" "$1"
  unzip "$temp_dir/font.zip" -d "$temp_dir"
  sudo mv "$temp_dir"/*.{ttf,otf} /usr/local/share/fonts/
  fc-cache -f -v
  rm -rf "$temp_dir"
}

echo "-- Beginning setup --"

echo "Creating directories"
cd ~/Documents
mkdir projects
mkdir repos
mkdir notes
mkdir fonts

cd ~

echo "Installing needed software"
sudo apt install i3 picom nitrogen rofi polybar flatpak konsole build-essential procps curl file git neofetch zsh unzip
flatpak install flathub app.zen_browser.zen
curl https://sh.rustup.rs -sSf | sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Why this way? Debian's version of neovim is extremely out of date.
# This is how I get up-to-date versions hthat are compatible with plugins.
# That being said, the plan is to run this script in Linux Mint or Ubuntu.
# Adjust as needed
brew install neovim stow

echo "Installing fonts"
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CodeNewRoman.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DepartureMono.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DroidSansMono.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Gohu.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuMono.zip
install_font https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuSans.zip

echo "Setting up git"
read -p " global git name  > " name
read -p " global git email > " email
read -p " global default branch name > " branch_name
git config --global user.name "$name"
git config --global user.email "$email"
git config --global init.defaultBranch $branch_name
git config --global core.editor "nvim"

echo "Cloning dotfiles"

cd .config

# i3
mkdir i3
git clone https://github.com/ChristianStout/i3-config.git i3/
mkdir polybar
ln -s i3/polybar.ini polybar/config.ini

# zsh
zsh_loc = which zsh
chsh -s $zsh_loc
mkdir zsh
git clone https://github.com/ChristianStout/my-zsh-config.git zsh/
./zsh/install-plugins.sh
ln -s zsh/.zshrc ~/.zshrc

# nvchad
mk ~.config/nvim
git clone https://github.com/NvChad/starter ~/.config/nvim

