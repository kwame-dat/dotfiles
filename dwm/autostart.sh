#!/bin/bash

xrdb -merge ~/.Xresources &

# cursor active at boot
xsetroot -cursor_name left_ptr &

# Setup trackpad
xinput --set-prop 13 "libinput Tapping Enabled" 1
xinput --set-prop 13 "libinput Natural Scrolling Enabled" 1
xinput --set-prop 13 "libinput Accel Speed" 1

# Caps lock map
xcape -e 'Caps_Lock=Escape' &

# Make caps lock control key
setxkbmap -option 'caps:ctrl_modifier' &

# Increase keyboard key repeat
xset r rate 220 80 &

#starting utility applications at boot time
nitrogen --restore &
nm-applet &
xfce4-power-manager &
numlockx on &
blueberry-tray &
compton &
/usr/bin/emacs --daemon &
dunst &
# optimus-manager-qt &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#starting user applications at boot time
nextcloud &
caffeine &
kdeconnect-indicator &
# slack &
