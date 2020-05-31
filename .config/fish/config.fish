set fish_greeting

# Composer export path
export PATH="$PATH:$HOME/.composer/vendor/bin"

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

# Composer | Docker Commands
alias dcu="docker-compose exec workspace composer update"
alias dci="docker-compose exec workspace composer install"
alias dcda="docker-compose exec workspace composer dump-autoload"


# PHP Test
alias t="vendor/bin/phpunit"
alias tc="vendor/bin/phpunit --coverage-html='tests/coverage/html'"
alias tf="vendor/bin/phpunit --filter"

# PHP Test | Docker Commands
alias dt="docker-compose exec workspace ./vendor/bin/phpunit"
alias dtc="docker-compose exec workspace ./vendor/bin/phpunit --coverage-html='tests/coverage/html'"
alias dtf="docker-compose exec workspace ./vendor/bin/phpunit --filter"

# Laravel
alias a="php artisan"
alias at="php artisan tinker"
alias am="php artisan migrate"
alias as="php artisan db:seed"

# Laravel | Docker Commands
alias da="docker-compose exec workspace php artisan"
alias dat="docker-compose exec workspace php artisan tinker"
alias dam="docker-compose exec workspace php artisan migrate"
alias das="docker-compose exec workspace php artisan db:seed"

# Docker
alias ds="docker ps"