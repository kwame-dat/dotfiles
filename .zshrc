export ZSH="/Users/tonyampomah/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    docker
    git-flow
    composer
    emacs
    node
    pass
    brew
    bower
    ansible
    docker
    docker-compose
    history-substring-search
    history
    command-not-found
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacsclient'
else
  export EDITOR='emacs'
fi

source ~/.aliases.zsh

# fnm
eval "$(fnm env --multi)"
