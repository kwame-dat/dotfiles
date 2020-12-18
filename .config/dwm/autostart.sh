#!/bin/bash
function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

xrandr --output eDP1 --off --output DP1 --primary --mode 3840x1600 --pos 0x0 --rotate normal --output DP2 --off --output DP3 --off --output VIRTUAL1 --off &

# cursor active at boot
xsetroot -cursor_name left_ptr &

# Setup my Touchpad to my liking
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Accel Speed" 1 &
                   
# Caps lock map    
xcape -e 'Caps_Lock=Escape' &

# Make caps lock control key
setxkbmap -option 'caps:ctrl_modifier,altwin:swap_lalt_lwin' &

# Increase keyboard key repeat
xset r rate 220 80 &

run "variety"
run "dunst"
run "dwmblocks"
run "nm-applet"
run "xfce4-power-manager"
run "blueberry-tray"
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom -b  --config ~/.config/picom/picom.conf &
/usr/bin/emacs --daemon &
run "nextcloud"
run "caffeine"
run "kdeconnect-indicator"
run "dropbox"
