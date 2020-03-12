if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# General
alias e="exit"
alias c="clear"
alias h="cd ~/"
alias o="open ."
alias desk="cd ~/Desktop"
alias db="cd ~/Databases"
alias down="cd ~/Downloads"
alias rr="source $ZSH/oh-my-zsh.sh"
alias r="cd ~/Repo/"
alias ckh="rm -rf ~/.ssh/known_hosts"
alias getKey="pbcopy < ~/.ssh/id_rsa.pub"
alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed"
alias ios="cd /Applications/Xcode.app/Contents/Developer/Applications && open -n Simulator.app"

# Composer
alias cu="composer update"
alias ci="composer install"
alias cda="composer dump-autoload"

# Docker
alias ds="docker ps"

# PHP Test
alias t="vendor/bin/phpunit"
alias tsd="vendor/bin/phpunit --order-by=defects --stop-on-defect"
alias test="vendor/bin/phpunit"
alias tc="vendor/bin/phpunit --coverage-html='tests/coverage/html'"
alias tf="vendor/bin/phpunit --filter"

# Laravel
alias art="php artisan"
alias tinker="php artisan tinker"
alias migrate="php artisan migrate"

# fnm
eval "$(fnm env --multi)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
