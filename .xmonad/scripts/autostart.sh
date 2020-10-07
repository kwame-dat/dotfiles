#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

(sleep 2; run $HOME/.config/polybar/launch.sh) &

# xrdb -merge ~/.Xresources &

# xrandr --output eDP1 --primary --mode 3840x2160 --pos 3840x0 --rotate normal --output DP1 --mode 3840x1600 --pos 0x327 --rotate normal --output DP2 --off --output DP3 --off --output VIRTUAL1 --off

#change your keyboard if you need it
#setxkbmap -layout be

#cursor active at boot
xsetroot -cursor_name left_ptr &

# Caps lock map and change key repeat
xcape -e 'Caps_Lock=Escape' &
setxkbmap -option 'caps:ctrl_modifier' &
xset r rate 220 80 &


#starting utility applications at boot time
nitrogen --restore &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
run volumeicon &
numlockx on &
blueberry-tray &
picom --config $HOME/.xmonad/scripts/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
/usr/bin/emacs --daemon &

# dunst &

#starting user applications at boot time
run nextcloud &
run caffeine &
# run slack &
