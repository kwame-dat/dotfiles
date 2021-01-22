set fish_greeting
function fish_user_key_bindings
  fish_vi_key_bindings
end

# Abbreviations
abbr -a -g vpn sudo openvpn --config Connection.ovpn
abbr -a -g kvpn sudo killall openvpn

# General
alias e="exit"
alias c="clear"
alias h="cd ~/"
alias o="open ."
alias down="cd ~/Downloads"
alias ckh="rm -rf ~/.ssh/known_hosts"
alias getKey="pbcopy < ~/.ssh/id_rsa.pub"

# Repo
alias rw1="cd ~/Repo/Work/1Projects"
alias rw2="cd ~/Repo/Work/2Areas"
alias rw3="cd ~/Repo/Work/3Resources"
alias rw4="cd ~/Repo/Work/4Archives"
alias rp1="cd ~/Repo/Personal/1Projects"
alias rp2="cd ~/Repo/Personal/2Areas"
alias rp3="cd ~/Repo/Personal/3Resources"
alias rp4="cd ~/Repo/Personal/4Archives"

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