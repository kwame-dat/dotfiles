#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 2; run $HOME/.config/polybar/launch.sh) &



xrdb -merge ~/.Xresources &

#cursor active at boot
xsetroot -cursor_name left_ptr &

# Caps lock map and change key repeat
xcape -e 'Caps_Lock=Escape' &
setxkbmap -option 'caps:ctrl_modifier' &
xset r rate 220 80 &

#starting utility applications at boot time
nitrogen --restore &
optimus-manager-qt &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
picom &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
/usr/bin/emacs --daemon &
# dunst &

#starting user applications at boot time
run nextcloud &
run caffeine &
run kdeconnect-indicator &
# run slack &
