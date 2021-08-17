#!/bin/bash
# source for the terminal
xrdb -merge $HOME/.xres &

# xrdb ~/.Xresources &

# font
xset fp+ $HOME/.fonts &
xset fp rehash &

# set keyboard layout to us
setxkbmap us &

# Setup my Touchpad to my liking
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Accel Speed" 1 &

# Keyboard changes
## make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps &

## make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'

## Increase keyboard key repeat
xset r rate 300 80 &

# variety &
nitrogen --restore &
nm-applet &
dunst &
xmodmap ~/.Xmodmap &
xbindkeys -f ~/.xbindkeysrc &
picom &
dwmblocks &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

nextcloud &
xbindkeys -f ~/.xbindkeysrc &
/usr/bin/emacs --daemon &
kdeconnect-indicator &
redshift &

# Start your wm!
exec dwm



# Starting utility applications at boot time

## starting user applications at boot time
