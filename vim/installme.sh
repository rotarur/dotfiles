sudo apt-get -y update

echo "Remove nano"
sudo apt -y purge nano

echo "Adding additional repositories"
sudo add-apt-repository -y universe

echo "Install apt-fast"
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get -y update
sudo apt-get -y install apt-fast

echo "Creating neovim folders and undodir"
nvimfoler=~/.config/nvim
mkdir -p $nvimfoler/undodir
cp init.vim $nvimfoler/

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing fonts-firecode"
sudo apt -y install fonts-firacode

sudo apt -y install nodejs npm yarn \
   docker.io docker-compose packer \
   ansible neovim fzf silversearcher-ag \
   apt-transport-https curl whois \
   terminator zsh containerd ruby-full \
   gnupg2 virtualbox

curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb

sudo apt -y install ./vagrant_2.2.6_x86_64.deb
rm -f vagrant_2.2.6_x86_64.deb

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt -y install kubectl

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo apt -y install ./minikube_latest_amd64.deb
rm -f minikube_latest_amd64.deb

sudo usermod -aG docker rotarur

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

git clone https://github.com/syndbg/goenv.git ~/.goenv

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* $HOME/bin

mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

echo "alias vim='nvim'" >> ~/.zshrc
echo "alias vi-fzf='vi \$(fzf)'\n" >> ~/.zshrc

echo "alias k=kubectl\n" >> ~/.zshrc
echo 'complete -F __start_kubectl k\n' >> ~/.zshrc

echo 'source <(kubectl completion zsh)\n' >> ~/.zshrc

echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
echo 'export PATH="$GOENV_ROOT/bin:$PATH"\n' >> ~/.zshrc

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"\n' >> ~/.zshrc

echo 'eval "$(goenv init -)"' >> ~/.zshrc
echo 'export PATH="$GOROOT/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.zshrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc

echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

echo 'eval "$(rbenv init -)"' >> ~/.zshrc

tfenv install 0.12.20
tfenv use 0.12.20

goenv install 1.15.3
goenv global 1.15.3
