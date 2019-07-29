export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

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
  tmux
  vagrant
  wp-cli
  xcode
  yarn
)

source $ZSH/oh-my-zsh.sh

source ~/.aliases.zsh
