export OSH=/home/tonya/.oh-my-bash

OSH_THEME="powerline-naked"

completions=(
  git
  composer
  ssh
  docker
  vagrant
  make
  vagrant
  docker-compose
)

aliases=(
  general
)

plugins=(
  git
  ansible
  bashmarks
)

source $OSH/oh-my-bash.sh

# Exports
export VISUAL="emacsclient -c"
export EDITOR=emacsclient
export MPD_HOST="localhost"
export MPD_PORT="6600"

# For Android Studio
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/java-14-openjdk

# For Gradle
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
