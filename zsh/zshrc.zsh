# Remove duplicates from history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

DISABLE_UNTRACKED_FILES_DIRTY="true"

# zsh completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# use nvim
[[ -n "$(command -v nvim)" ]] && alias vim='nvim'; alias vi='nvim'
[[ -n "$(command -v nvim)" ]] && export EDITOR='nvim'
[[ -n "$(command -v nvim)" ]] && export GIT_EDITOR='nvim'

# fzf
[[ -n "$(command -v fzf)" ]] && alias vfzf='vi $(fzf --height 40%)'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# gh
alias ghpc='gh pr create'
alias ghpm='gh pr merge'
alias ghpmdr='gh pr merge -d -r'

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
alias kdn='k describe node'

# itialise completions with ZSH's compinit
autoload -U +X compinit && compinit

source <(kubectl completion zsh)
complete -F __start_kubectl k

# aws
alias assume-role='function(){
   unset AWS_SECRET_ACCESS_KEY
   unset AWS_SESSION_TOKEN
   unset AWS_SECURITY_TOKEN
   unset ASSUMED_ROLE
   eval $(command assume-role -duration=12h $@)
}'

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.asdf:$PATH"
export PATH="${HOME}/Library/Python/2.7/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="${HOME}/.local/share/solana/install/active_release/bin:$PATH"
export PACKER_HOME_DIR=$HOME/.packer.d

source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh

# reload zsh
alias reload!='RELOAD=1 source ~/.zshrc'

# GPG
alias gpg-restart='gpgconf --kill gpg-agent; gpgconf --launch gpg-agent'

# GPG configuration
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
echo -e "# Enable gpg to use the gpg-agent\nuse-agent" > ${HOME}/.gnupg/gpg.conf

. $HOME/.asdf/asdf.sh

# append completions to fpath
#fpath=(${ASDF_DIR}/completions $fpath)

#eval $(register-python-argcomplete ansible)
#eval $(register-python-argcomplete ansible-config)
#eval $(register-python-argcomplete ansible-console)
#eval $(register-python-argcomplete ansible-doc)
#eval $(register-python-argcomplete ansible-galaxy)
#eval $(register-python-argcomplete ansible-inventory)
#eval $(register-python-argcomplete ansible-playbook)
#eval $(register-python-argcomplete ansible-pull)
#eval $(register-python-argcomplete ansible-vault)

