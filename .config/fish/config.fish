set fish_greeting

# Composer export path

# General
alias e="exit"
alias c="clear"
alias h="cd ~/"
alias o="open ."
alias down="cd ~/Downloads"
alias ckh="rm -rf ~/.ssh/known_hosts"
alias getKey="pbcopy < ~/.ssh/id_rsa.pub"

# Repo
alias r="cd ~/Repo/"
alias wp="cd ~/Repo/Work/1Projects"
alias wa="cd ~/Repo/Work/2Areas"
alias pp="cd ~/Repo/Personal/1Projects"
alias pa="cd ~/Repo/Personal/2Areas"

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
alias art="php artisan"
alias rl="php artisan route:list"
alias m="php artisan migrate"
alias dbs="php artisan db:seed"
alias mf="php artisan migrate:fresh"
alias mfs="php artisan migrate:fresh --seed"
alias pi="php artisan passport:install"
alias tinker="php artisan tinker"
alias dusk="php artisan dusk"
alias at="php artisan tinker"

# Laravel | Docker Commands
alias da="docker-compose exec workspace php artisan"
alias dat="docker-compose exec workspace php artisan tinker"
alias dam="docker-compose exec workspace php artisan migrate"
alias das="docker-compose exec workspace php artisan db:seed"

# Docker
alias ds="docker ps"

# Emacs
alias emc="emacsclient -c"
export VISUAL="emacsclient -c"
export EDITOR="emacsclient -t"

export MPD_HOST="localhost"
export MPD_PORT="6600"