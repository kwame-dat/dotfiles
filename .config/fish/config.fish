set fish_greeting
set -U fish_key_bindings fish_default_key_bindings

# Vpn
abbr -a -g cvpn sudo openvpn --config ~/Documents/Work/3Resources/vpn/Connection.ovpn
abbr -a -g kvpn sudo killall openvpn

# General
abbr -a -g h cd ~/
abbr -a -g o open .
abbr -a -g ckh rm -rf ~/.ssh/known_hosts
abbr -a -g getKey pbcopy < ~/.ssh/id_rsa.pub

abbr -a -g r1 cd ~/Repo/Work/1Projects
abbr -a -g r2 cd ~/Repo/Work/2Areas
abbr -a -g r3 cd ~/Repo/Work/3Resources
abbr -a -g r4 cd ~/Repo/Work/4Archives
abbr -a -g rr1 cd ~/Repo/Personal/1Projects
abbr -a -g rr2 cd ~/Repo/Personal/2Areas
abbr -a -g rr3 cd ~/Repo/Personal/3Resources
abbr -a -g rr4 cd ~/Repo/Personal/4Archives
abbr -a -g d cd ~/Downloads
abbr -a -g dd cd ~/Documents
abbr -a -g d1 cd ~/Documents/Work/1Projects
abbr -a -g d2 cd ~/Documents/Work/2Areas
abbr -a -g d3 cd ~/Documents/Work/3Resources
abbr -a -g d4 cd ~/Documents/Work/4Archives
abbr -a -g dd1 cd ~/Documents/Personal/1Projects
abbr -a -g dd2 cd ~/Documents/Personal/2Areas
abbr -a -g dd3 cd ~/Documents/Personal/3Resources
abbr -a -g dd4 cd ~/Documents/Personal/4Archives

# Composer
abbr -a -g cu composer update
abbr -a -g ci composer install
abbr -a -g cda composer dump-autoload

# Composer | Docker Commands
abbr -a -g dcu docker-compose exec workspace composer update
abbr -a -g dci docker-compose exec workspace composer install
abbr -a -g dcda docker-compose exec workspace composer dump-autoload

# PHP Test
abbr -a -g t bin/phpunit
abbr -a -g tc bin/phpunit --coverage-html='tests/coverage/html'
abbr -a -g tf bin/phpunit --filter

# PHP Test | Docker Commands
abbr -a -g dt docker-compose exec workspace bin/phpunit
abbr -a -g dtc docker-compose exec workspace bin/phpunit --coverage-html='tests/coverage/html'
abbr -a -g dtf docker-compose exec workspace bin/phpunit --filter

# Laravel
abbr -a -g art php artisan
abbr -a -g rl php artisan route:list
abbr -a -g m php artisan migrate
abbr -a -g dbs php artisan db:seed
abbr -a -g mf php artisan migrate:fresh
abbr -a -g mfs php artisan migrate:fresh --seed
abbr -a -g pi php artisan passport:install
abbr -a -g tinker php artisan tinker
abbr -a -g dusk php artisan dusk
abbr -a -g at php artisan tinker

# Laravel | Docker Commands
abbr -a -g da docker-compose exec workspace php artisan
abbr -a -g dat docker-compose exec workspace php artisan tinker
abbr -a -g dam docker-compose exec workspace php artisan migrate
abbr -a -g das docker-compose exec workspace php artisan db:seed

# Docker
abbr -a -g ds docker ps

# Emacs
abbr -a -g emc emacsclient -c


# Exports
export VISUAL="emacsclient -c"
export EDITOR="emacsclient -t"
export MPD_HOST="localhost"
export MPD_PORT="6600"
