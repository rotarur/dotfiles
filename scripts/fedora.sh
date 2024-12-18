#!/bin/bash

ZSRCDOT=~/.dotfiles/zsh/zshrc.cfg

PACKAGES="flatpak neovim git curl whois zsh btop nmap tmux
jq the_silver_searcher gnupg2 podman vagrant zoxide kitty stow
readline-devel libtermcap-devel ncurses-devel libevent-devel
python3-devel
"
sudo dnf install $PACKAGES

# remove packages
REMOVE_PKG="nano"

sudo dnf remove $REMOVE_PKG

flatpak install bitwarden

sudo systemctl enable podman
sudo systemctl start podman

if [ -f ~/.zshrc ]; then
   echo "Configuring zshrc"

   TMPDOFILE=$(grep zshrc.zsh ~/.zshrc)
   if [ "$TMPDOFILE" ]; then
      echo "zshrc.dotfiles will be adjusted"
      sed "s%${TMPDOFILE}%source\ ${ZSRCDOT}%g" -i ~/.zshrc
   else
      echo "zshrc.dotfiles will be configured"
      echo "source ${ZSRCDOT}" >> ~/.zshrc
   fi

   echo "Configuring zsh plugins"
   sed '/^source\ \$ZSH\/oh-my-zsh.sh/i source\ \$HOME\/.dotfiles\/zsh\/plugins.sh' -i ~/.zshrc
fi

source ${ZSRCDOT}

