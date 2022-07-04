#!/bin/bash

if [ ! -d ~/.dotfiles ]; then
   mkdir ~/.dotfiles
fi

cp -r . ~/.dotfiles

ZSRCDOT=~/.dotfiles/zsh/zshrc.cfg

# network-manager-openconnect-gnome if not for KDE - fix it

PACKAGES="yarn docker.io docker-compose packer
   neovim silversearcher-ag gimp ansible
   apt-transport-https curl whois fzf awscli
   terminator zsh containerd ruby-full python3-venv
   gnupg2 virtualbox keepassx python-setuptools
   default-jre python3-pip python python-dev evince
   jq dconf-editor tmux fonts-firacode fonts-powerline
   tree atop nmap openconnect network-manager-openconnect
   network-manager-openconnect-gnome gnome-terminal
   vagrant linux-headers-generic"

sudo dpkg-reconfigure virtualbox-dkms
sudo dpkg-reconfigure virtualbox

echo "Remove nano"
sudo apt -y purge nano

echo "Install pip requirements"
sudo pip3 install -r python_packages.txt

sudo apt -y install --no-install-recommends software-properties-common

echo "Adding additional repositories"
sudo add-apt-repository -y universe

echo "Install apt-fast"
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get -y update
echo -e "1\n5\nno\n" | sudo apt-get -y install apt-fast

echo "Install Atom Editor"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt -y update
sudo apt -y install atom

echo "Installing packages"
sudo apt update && sudo apt -y install $PACKAGES

if [[ ! -n "$(command -v snap)" ]]; then
   echo "Installing snapd on system"
   sudo apt -y install snapd
fi

echo "Install telegram-desktop using snap"
sudo snap install telegram-desktop

echo "Install bitwarden with snap"
sudo snap install bitwarden

echo "Install zoom-client with snap"
sudo snap install zoom-client

echo "Install vscode with snap"
sudo snap install code --classic

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ZSH=$(which zsh)

echo "Configuring tmux"
ln -sf ${HOME}/.dotfiles/tmux/tmux.conf ${HOME}/.tmux.conf

echo "Install ohmyzsh"
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh
echo -e "Y\n" | sh install.sh
rm -f install.sh

echo "Install asdf package manager"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
. $HOME/.asdf/asdf.sh

echo "Install nodejs with asdf"
asdf plugin-add nodejs
asdf install nodejs latest && \
asdf global nodejs latest

echo "Install argocd with asdf"
asdf plugin-add argocd https://github.com/beardix/asdf-argocd.git
asdf install argocd latest &&\
asdf global argocd latest

echo "Install helm with asdf"
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git &&\
asdf install helm latest &&\
asdf global helm latest

echo "Install kustomize with asdf"
asdf plugin-add kustomize https://github.com/Banno/asdf-kustomize.git &&\
asdf install kustomize latest &&\
asdf global kustomize latest

echo "Install awscli with asdf"
asdf install awscli latest &&\
asdf global awscli latest

echo "Install kubectl with asdf"
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git &&\
asdf install kubectl latest &&\
asdf global kubectl latest

echo "Install kubectx with asdf"
asdf plugin add kubectx
asdf install kubectx 0.8.0
asdf global kubectx 0.8.0

echo "Install minikube with asdf"
asdf plugin-add minikube https://github.com/alvarobp/asdf-minikube.git &&\
asdf install minikube latest &&\
asdf global minikube latest

echo "Install golang with asdf"
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest && \
asdf global golang latest

echo "Install terraform with asdf"
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf install terraform latest && \
asdf global terraform latest

echo "Install sops with asdf"
asdf plugin-add sops https://github.com/feniix/asdf-sops.git
asdf install sops latest && \
asdf global sops latest

echo "Changing default shell"
sudo usermod -s $ZSH $(whoami)

echo "Adding to docker group"
GROUP=$(grep docker /etc/group)
if [ ${GROUP} ]; then
   sudo usermod -aG docker $(whoami)
fi

echo "Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [ -f ~/.zshrc ]; then
   echo "Configuring zshrc"

   TMPDOFILE=$(grep zshrc.cfg ~/.zshrc)
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

echo "Configuring vim"
~/.dotfiles/vim/vim.install.sh

echo "Installing alacritty"
git clone https://github.com/alacritty/alacritty.git /var/tmp/alacritty
cd /var/tmp/alacritty
make app
sudo cp cp -r target/release/osx/Alacritty.app /Applications/

echo "Configuring alacritty"
ln -s ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/

git config --global push.default current
git config --global pull.default current

echo "Configuring sysctl"
cat << EOF | sudo tee -a /etc/sysctl.conf
vm.overcommit_memory = 1
EOF
sudo sysctl -p

echo "Done."
