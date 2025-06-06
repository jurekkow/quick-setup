#!/usr/bin/env bash

sudo apt-get update

# oh-my-zsh
sudo apt install -y zsh
touch ~/.zshrc
chsh -s "$(which zsh)"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
source ~/.zshrc

# docker
sudo apt-get install -y ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# K8s (kubectl, kubelogin)
az aks install-cli

# pyenv
curl -fsSL https://pyenv.run | bash

# .NET
sudo apt-get install -y dotnet-sdk-8.0

# Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v # Should print "v22.16.0".
nvm current # Should print "v22.16.0".
npm -v # Should print "10.9.2".

# tmux
sudo apt install -y tmux
echo "
# remap prefix from \'C-b\' to \'C-a\'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind \'\"\'
unbind %

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

# bind shortcut for renaming window to current dirname
bind g rename-window \"#{b:pane_current_path}\"
" > ~/.tmux.conf
tmux source-file ~/.tmux.conf

# Git LFS
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo sh

# custom aliases
echo "
alias m=\"mypy .\"
alias t=\"pytest tests/\"
alias c=\"r && m && t\"
alias pp=\"export PYTHONPATH=$YTHONPATH:$PWD\"

alias gce=\"gc --allow-empty\"
alias gbre=\"git branch --sort=-committerdate | head -n 5\"
" >> ~/.zshrc
source ~/.zshrc

# htop
sudo apt-get install -y htop

sudo apt-get update
