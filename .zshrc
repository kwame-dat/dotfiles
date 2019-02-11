# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR='nvim'

# General
alias e="exit"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias h="cd ~/"
alias o="open ."
alias d="cd ~/Docs"
alias vim="nvim"
alias dk="cd ~/Desktop"
alias db="cd ~/Databases"
alias dl="cd ~/Downloads"
alias rr="source ~/.zshrc"
alias r="cd ~/Repositories"
alias prettify="python -mjson.tool"
alias ckh="rm -rf ~/.ssh/known_hosts"
alias getKey="pbcopy < ~/.ssh/id_rsa.pub"
alias gogc="chrome tests/coverage/html/index.html"
alias gosc="open -a Safari tests/coverage/html/index.html"
alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed"
alias ios="cd /Applications/Xcode.app/Contents/Developer/Applications && open -n Simulator.app"


# Editting Config Files
alias ez="nvim ~/.zshrc"
alias ep="nvim ~/.zpreztorc"
alias et="nvim ~/.tmux.conf"
alias eh="sudo nvim /etc/hosts"
alias eal="nvim ~/.config/alacritty/alacritty.yml"


# Composer
alias cu="composer update"
alias ci="composer install"
alias cda="composer dump-autoload"


# Tmux & Tmuxinator
alias s="tmuxinator start "
alias sm="tmuxinator start elico-module"
alias ss="tmuxinator start elico-service"
alias mux="tmuxinator"
alias ta="tmux attach"


# Docker
alias ds="docker ps"


# PHP Test
alias t="bin/phpunit"
alias tc="bin/phpunit --coverage-html='tests/coverage/html'"
alias tpc="vendor/bin/phpunit --coverage-html='tests/coverage/html'"
alias tp="vendor/bin/phpunit"


# Laraval
alias art="php artisan"
alias tf="bin/phpunit --filter"
alias tinker="php artisan tinker"
alias migrate="php artisan migrate"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
