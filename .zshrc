export ZSH="~/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  ansible
  aws
  bower
  brew
  bundler
  cp
  docker
  docker-compose
  docker-machine
  dotenv
  emacs
  fd
  git
  git-flow
  gitignore
  history
  httpie
  jira
  laravel
  node
  node
  osx
  symfony
  vagrant
  yarn
)

source $ZSH/oh-my-zsh.sh

source ~/.aliases.zsh
