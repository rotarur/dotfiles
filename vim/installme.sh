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

echo "Installing fonts-firecode"
sudo apt -y install fonts-firacode

sudo apt -y install nodejs npm yarn \
   docker.io docker-compose packer \
   ansible neovim fzf silversearcher-ag \
   apt-transport-https curl whois \
   terminator zsh containerd

sudo usermod -aG docker rotarur
