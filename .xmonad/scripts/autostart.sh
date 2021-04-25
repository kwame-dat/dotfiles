#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# cursor active at boot
xsetroot -cursor_name left_ptr &

# Setup my Touchpad to my liking
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Accel Speed" 1 &

# Keyboard changes
## make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps

## make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'

## Increase keyboard key repeat
xset r rate 300 80 &

xrdb ~/.Xresources

# Starting utility applications at boot time
run nm-applet &
run picom &
run dunst &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run variety &
xmodmap ~/.Xmodmap &

# starting user applications at boot time
run /usr/bin/emacs --daemon &
run nextcloud &
run kdeconnect-indicator &
run xbindkeys -f ~/.xbindkeysrc &
run redshift &
