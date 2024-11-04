#!/usr/bin/env bash

set -xe

CONFIG=vm

sh <(curl -L https://nixos.org/nix/install) --no-daemon

. "$HOME/.nix-profile/etc/profile.d/nix.sh"

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell "<home-manager>" -A install
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

git clone https://github.com/compromyse/dotfiles $HOME/.config/home-manager/dotfiles
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

rm $HOME/.config/home-manager/home.nix
ln -s $HOME/.config/home-manager/dotfiles/machines/$CONFIG/home.nix $HOME/.config/home-manager/home.nix

sudo apt-get purge -y git
sudo apt-get autoremove -y

home-manager build
home-manager switch -b backup

rm $HOME/result

~/.tmux/plugins/tpm/bin/install_plugins
