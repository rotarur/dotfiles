#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Check for package manager to determine distribution
  if command -v apt &>/dev/null; then
    OS="linux-debian"
  elif command -v pacman &>/dev/null; then
    OS="linux-arch"
  else
    echo "Error: This script requires Debian/Ubuntu (apt), Arch Linux (pacman), or macOS"
    echo "Detected Linux but neither apt nor pacman is available. Unsupported distribution."
    exit 1
  fi
else
  echo "Unsupported OS: $OSTYPE"
  echo "This script supports macOS, Debian/Ubuntu Linux, and Arch Linux only."
  exit 1
fi

echo "Detected OS: $OS"

# Detect if running in a container
IN_CONTAINER=false
if [ -f /.dockerenv ] ||
  [ -n "${container:-}" ] ||
  grep -qa "container=" /proc/1/environ 2>/dev/null ||
  grep -q docker /proc/1/cgroup 2>/dev/null ||
  [ -n "${KUBERNETES_SERVICE_HOST:-}" ]; then
  IN_CONTAINER=true
fi

# Determine if we need sudo
# If in container and running as root, don't use sudo
# Otherwise, use sudo
if [ "$IN_CONTAINER" = true ] && [ "$(id -u)" -eq 0 ]; then
  SUDO_CMD=""
  echo "Running in container as root - sudo not required"
elif [ "$(id -u)" -eq 0 ]; then
  SUDO_CMD=""
  echo "Running as root - sudo not required"
else
  SUDO_CMD="sudo"
  echo "Running as regular user - will use sudo"
fi

if [ ! -d ~/.dotfiles ]; then
  mkdir ~/.dotfiles
fi

cp -r . ~/.dotfiles

ZSRCDOT=~/.dotfiles/zsh/zshrc.zsh

# OS-specific package installation
if [ "$OS" == "linux-debian" ]; then
  # Linux (Debian/Ubuntu) packages
  PACKAGES="yarn docker.io docker-compose
       neovim silversearcher-ag gimp ansible
       apt-transport-https curl whois
       terminator zsh containerd ruby-full python3-venv
       gnupg2 keepassx default-jre python3-pip evince
       jq dconf-editor tmux fonts-firacode fonts-powerline
       tree atop nmap openconnect network-manager-openconnect
       network-manager-openconnect-gnome gnome-terminal
       linux-headers-generic fzf stow"

  # Set non-interactive mode to avoid debconf issues
  export DEBIAN_FRONTEND=noninteractive

  echo "Update cache"
  ${SUDO_CMD} apt update

  echo "Remove nano"
  if command -v nano &>/dev/null; then
    ${SUDO_CMD} apt -y purge nano
  fi

  echo "Install pip requirements"
  ${SUDO_CMD} pip3 install -r python_packages.txt

  ${SUDO_CMD} apt -y install --no-install-recommends software-properties-common

  echo "Adding additional repositories"
  ${SUDO_CMD} add-apt-repository -y universe

  ${SUDO_CMD} apt-get -y install libterm-readline-perl-perl

  echo "Install apt-fast"
  ${SUDO_CMD} add-apt-repository -y ppa:apt-fast/stable
  ${SUDO_CMD} apt-get -y update

  # Use debconf-set-selections to pre-configure apt-fast
  echo "apt-fast apt-fast/maxconnections string 5" | ${SUDO_CMD} debconf-set-selections
  echo "apt-fast apt-fast/dlflag boolean true" | ${SUDO_CMD} debconf-set-selections
  ${SUDO_CMD} apt-get -y install apt-fast

  echo "Installing packages"
  ${SUDO_CMD} apt update && ${SUDO_CMD} apt -y install $PACKAGES

  # if [[ ! -n "$(command -v snap)" ]]; then
  #    echo "Installing snapd on system"
  #    ${SUDO_CMD} apt -y install snapd
  # fi

  # echo "Install telegram-desktop using snap"
  # ${SUDO_CMD} snap install telegram-desktop

  # echo "Install bitwarden with snap"
  # ${SUDO_CMD} snap install bitwarden

  # echo "Install zoom-client with snap"
  # ${SUDO_CMD} snap install zoom-client

  # echo "Install vscode with snap"
  # ${SUDO_CMD} snap install code --classic

elif [ "$OS" == "linux-arch" ]; then
  # Arch Linux packages
  PACKAGES="yarn docker docker-compose
       neovim the_silver_searcher gimp ansible
       curl whois terminator zsh containerd ruby
       python python-pip gnupg keepassxc jre-openjdk
       evince jq dconf-editor tmux ttf-fira-code
       ttf-powerline-fonts tree atop nmap openconnect
       networkmanager-openconnect networkmanager-openconnect-gnome
       gnome-terminal linux-headers fzf stow"

  echo "Update package database"
  ${SUDO_CMD} pacman -Sy

  echo "Remove nano if installed"
  if command -v nano &>/dev/null; then
    ${SUDO_CMD} pacman -Rns --noconfirm nano
  fi

  echo "Installing packages"
  ${SUDO_CMD} pacman -S --needed --noconfirm $PACKAGES

  echo "Install pip requirements"
  ${SUDO_CMD} pip3 install -r python_packages.txt

elif [ "$OS" == "macos" ]; then
  # macOS packages using Homebrew
  if [[ ! -n "$(command -v brew)" ]]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "Updating Homebrew"
  brew update

  echo "Installing packages with Homebrew"
  brew install yarn docker docker-compose packer \
    neovim the_silver_searcher gimp ansible \
    curl whois zsh containerd ruby python@3.11 \
    gnupg keepassxc python-setuptools \
    openjdk python@3.11 jq tmux \
    tree nmap openconnect stow

  # echo "Installing cask packages"
  # brew install --cask virtualbox keepassxc \
  #     telegram zoom visual-studio-code atom

  # echo "Install pip requirements"
  # pip3 install -r python_packages.txt
fi

ZSH=$(which zsh)

echo "Install ohmyzsh"
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh
echo -e "Y\n" | sh install.sh
rm -f install.sh

# Change shell to zsh on Linux
if [[ "$OS" == "linux-debian" ]] || [[ "$OS" == "linux-arch" ]]; then
  if [ "$SHELL" != "$ZSH" ]; then
    echo "Changing default shell to zsh"
    chsh -s $ZSH
    echo "Shell changed to zsh. Please log out and log back in for changes to take effect."
  else
    echo "Shell is already set to zsh"
  fi
fi

if ! command -v mise &>/dev/null; then
  echo "Install mise"
  curl https://mise.run | sh
  # Add mise to current shell, if not already available (may require opening a new shell)
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ ! -d ~/.config ]; then
  echo "Create ~/.config directory"
  mkdir -p ~/.config
fi

echo "Stow .dotfiles"
stow -t ~/.config -d ~/.dotfiles/stow/.config . --adopt

echo "Install all packages using mise from mise.toml"
mise install

# Set global versions for all tools from config.toml
CONFIG_FILE=""
if [ -f ~/.config/mise/config.toml ]; then
  CONFIG_FILE=~/.config/mise/config.toml
elif [ -f ~/.dotfiles/stow/.config/mise/config.toml ]; then
  CONFIG_FILE=~/.dotfiles/stow/.config/mise/config.toml
fi

if [ -n "$CONFIG_FILE" ]; then
  echo "Setting global versions for all mise tools from $CONFIG_FILE"
  # Extract tools and versions from config.toml and format as tool@version
  # Parse lines in [tools] section that match: tool = "version"
  # Use sed to extract from [tools] section to end of file, then grep and format
  TOOLS=$(sed -n '/^\[tools\]/,$p' "$CONFIG_FILE" |
    grep -v '^\[' |
    grep -E '^\s*[^[:space:]#=]+\s*=\s*"' |
    sed -E 's/^[[:space:]]*([^[:space:]=]+)[[:space:]]*=[[:space:]]*"([^"]+)".*/\1@\2/' |
    tr '\n' ' ')

  if [ -n "$TOOLS" ]; then
    echo "Found tools: $TOOLS"
    mise use --global $TOOLS
  else
    echo "No tools found in mise config.toml"
    echo "Debug: Checking config file content..."
    echo "Config file: $CONFIG_FILE"
    echo "Lines from [tools] section:"
    sed -n '/^\[tools\]/,$p' "$CONFIG_FILE" | head -15
  fi
else
  echo "mise config.toml not found at ~/.config/mise/config.toml or ~/.dotfiles/stow/.config/mise/config.toml"
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
    echo "source ${ZSRCDOT}" >>~/.zshrc
  fi

  echo "Configuring zsh plugins"
  sed '/^source\ \$ZSH\/oh-my-zsh.sh/i source\ \$HOME\/.dotfiles\/zsh\/plugins.sh' -i ~/.zshrc
fi

source ${ZSRCDOT}

# curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# if [ "$OS" == "linux" ]; then
#     echo "Configuring sysctl"
#     cat << EOF | ${SUDO_CMD} tee -a /etc/sysctl.conf
# vm.overcommit_memory = 1
# EOF
#     ${SUDO_CMD} sysctl -p
# fi

echo "Done."
