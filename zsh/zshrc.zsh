# Remove duplicates from history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from each command line being added to the history.

WEZTERM_IN_TMUX=1

HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

DISABLE_UNTRACKED_FILES_DIRTY="true"

OLLAMA_HOST="0.0.0.0"

# use nvim
[[ ! -z "$(command -v nvim)" ]] && alias vim='nvim'; alias vi='nvim'
[[ ! -z "$(command -v nvim)" ]] && export EDITOR='vim'
[[ ! -z "$(command -v nvim)" ]] && export GIT_EDITOR='vim'

# fzf
# [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ ! -z "$(command -v fzf)" ]] && source <(fzf --zsh); alias fvi='vi $(fzf --height 40%)'
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --tmux bottom,50% --layout=default --border --preview 'cat {}' --color=hl:#2dd4bf"
alias fman="compgen -c | fzf | xargs man"

# fzf-git
[[ -f ~/.fzf-git.zsh ]] && source ~/.fzf-git.zsh

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias zed='open -a /Applications/Zed.app/Contents/MacOS/zed "$@"'
  alias watcha='watch -d -n 1 '
fi
alias zj='zellij options --theme gruvbox-dark'
alias myip='curl ipinfo.io'

alias rmf='rm -rf'
alias df='df -h'
alias du='du -h -c'
alias gs='git status'

# tmux
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-sesion s'
alias tx='tmux'

# terraform
alias tf='terraform'

# terragrunt
alias tg='terragrunt'

# gh
alias ghpc='gh pr create'
alias ghpm='gh pr merge'
alias ghpmdr='gh pr merge -d -r'

# GNU
[[ ! -z "$(command -v gsed)" ]] && alias sed=$(which gsed)

. "$HOME/.cargo/env"

# kitty aliases
# if [ ! -z "$(command -v kitty)" ]; then
#     alias diff="kitten diff"
# fi
# source custom configurations
# these configurations are ignored when
# committed
[ -f ${HOME}/.dotfiles/zsh/custom_configs.sh ] && source ${HOME}/.dotfiles/zsh/custom_configs.sh

# kubectx
alias kx='kubectx'

# kubectl
alias k=kubectl
alias k-get-all-images="kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{\"\n\"}{.metadata.name}{\":\t\"}{range .spec.containers[*]}{.image}{\", \"}{end}{end}' | sort"
alias kgc='k config get-contexts -o name'
alias kcc='k config current-context'
alias kuc='k config use-context'
alias kd='k describe'
alias kdn='k describe node'
alias kdi='k describe ingress'
alias kg='k get'
alias kgp='k get pod'
alias kgi='k get ingress'
alias kgdp='k get deployment'
alias kgds='k get daemonset'
alias kgsvc='k get service'
alias kgscrt='k get secret'

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="${HOME}/.local/share/solana/install/active_release/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="${HOME}/Library/Python/2.7/bin:$PATH"
  export PATH="/opt/homebrew/bin:$PATH"
fi

export XDG_CONFIG_HOME=$HOME/.config

# reload zsh
alias reload!='RELOAD=1 source ~/.zshrc'

# GPG
alias gpg-restart='gpgconf --kill gpg-agent; gpgconf --launch gpg-agent'

# GPG configuration
if [ ! -d $HOME/.gnupg ]; then
   mkdir $HOME/.gnupg
fi

# Set GPG_TTY only if we have a TTY
if [ -t 0 ]; then
   export GPG_TTY=$(tty)
   gpgconf --launch gpg-agent
else
   # For non-interactive environments, try to use a pseudo-TTY or disable pinentry
   export GPG_TTY=$(tty 2>/dev/null || echo "/dev/tty")
fi

# Ensure gpg-agent is running
gpgconf --launch gpg-agent 2>/dev/null || true

# Configure gpg to use agent (only if file doesn't exist to avoid overwriting)
if [ ! -f ${HOME}/.gnupg/gpg.conf ] || ! grep -q "use-agent" ${HOME}/.gnupg/gpg.conf; then
   echo -e "# Enable gpg to use the gpg-agent\nuse-agent" >> ${HOME}/.gnupg/gpg.conf
fi

eval "$(~/.local/bin/mise activate zsh)"

# zoxide better cd
eval "$(zoxide init zsh)"
alias cd="z"

export PATH="$(go env GOPATH)/bin:$PATH"


eval "$(atuin init zsh)"

source <(kubectl completion zsh)
# complete -F __start_kubectl k

#eval $(register-python-argcomplete ansible)
#eval $(register-python-argcomplete ansible-config)
#eval $(register-python-argcomplete ansible-console)
#eval $(register-python-argcomplete ansible-doc)
#eval $(register-python-argcomplete ansible-galaxy)
#eval $(register-python-argcomplete ansible-inventory)
#eval $(register-python-argcomplete ansible-playbook)
#eval $(register-python-argcomplete ansible-pull)
#eval $(register-python-argcomplete ansible-vault)
