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
                   
# Caps lock map    
xcape -e 'Caps_Lock=Escape' &

# Make caps lock control key & sway alt with super key
setxkbmap -option 'caps:ctrl_modifier,altwin:swap_lalt_lwin' &

# Increase keyboard key repeat
xset r rate 220 80 &

(sleep 2; run $HOME/.config/polybar/launch.sh) &

#change your keyboard if you need it
#setxkbmap -layout be

#cursor active at boot
xsetroot -cursor_name left_ptr &

#start ArcoLinux Welcome App
run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop

#starting utility applications at boot time
run variety &
run nm-applet &
run xfce4-power-manager &
numlockx on &
picom &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
# run pamac-tray &

#starting user applications at boot time
/usr/bin/emacs --daemon &
run nextcloud &
run caffeine &
run kdeconnect-indicator &
