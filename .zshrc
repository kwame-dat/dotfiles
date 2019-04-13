# Source Prezto.
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
alias r="cd ~/Repositories"
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
alias t="bin/phpunit"
alias tc="bin/phpunit --coverage-html='tests/coverage/html'"
alias tf="bin/phpunit --filter"
alias tp="vendor/bin/phpunit"
alias tpc="vendor/bin/phpunit --coverage-html='tests/coverage/html'"

# Laraval
alias art="php artisan"
alias tinker="php artisan tinker"
alias migrate="php artisan migrate"

# Ledger
alias balance="cd /Users/tonyampomah/Documents/Finance && ledger -f index.ledger balance checking -R"
alias income='cd /Users/tonyampomah/Documents/Finance && ledger -f index.ledger balance income deductions -p "last month"'
alias expenses='cd /Users/tonyampomah/Documents/Finance && ledger -f index.ledger balance expenses -p "this month"'
alias budget='cd /Users/tonyampomah/Documents/Finance && ledger --empty -S -T -f index.ledger balance ^assets:budget'
