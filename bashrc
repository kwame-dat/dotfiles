export OSH=/home/kwame-dat/.oh-my-bash

OSH_THEME="bakke"

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

# Aliases for software managment
# pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'

# yay as aur helper - updates everything
alias pksyua="yay -Syu --noconfirm"
alias upall="yay -Syu --noconfirm"

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#add new fonts
alias update-fc='sudo fc-cache -fv'

neofetch
