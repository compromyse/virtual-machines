#!/usr/bin/env bash

set -xe

nix-shell '<home-manager>' -A install
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:compromyse/dotfiles $HOME/.config/home-manager/dotfiles

rm $HOME/.config/home-manager/home.nix
ln -s $HOME/.config/home-manager/dotfiles/machines/v/home.nix $HOME/.config/home-manager/home.nix

sudo apt-get purge -y git
sudo apt-get autoremove -y

home-manager build
home-manager switch -b backup

git clone git@github.com:tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
