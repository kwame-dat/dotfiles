export ZSH="/Users/tonyampomah/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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
# Composer
export PATH="$PATH:$HOME/.composer/vendor/bin"
# PHP
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
# GNU Coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# GoPath
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
