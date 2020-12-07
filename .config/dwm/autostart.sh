#!/bin/bash
function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

if xrandr | grep -q "^DP1 connected"
then
    ln -sf /home/tonya/Repo/2Areas/dotfiles/.Xresources-ultrawide /home/tonya/.Xresources &
    ln -sf /home/tonya/Repo/2Areas/dotfiles/.profile-ultrawide /home/tonya/.profile &
    xrandr --output eDP1 --off --output DP1 --primary --mode 3840x1600 --pos 0x0 --rotate normal --output DP2 --off --output DP3 --off --output VIRTUAL1 --off &
    xrdb -merge ~/.Xresources &
else
    ln -sf /home/tonya/Repo/2Areas/dotfiles/.Xresources ~/ &
    ln -sf /home/tonya/Repo/2Areas/dotfiles/.profile /home/tonya/.profile &
    xrdb -merge ~/.Xresources &
fi

# cursor active at boot
xsetroot -cursor_name left_ptr &

# Setup my Touchpad to my liking
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput --set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Accel Speed" 1 &
                   
# Caps lock map    
xcape -e 'Caps_Lock=Escape' &

# Make caps lock control key
setxkbmap -option 'caps:ctrl_modifier' &

# Increase keyboard key repeat
xset r rate 220 80 &

run "variety"
run "dwmblocks"
run "picom"
run "nm-applet"
run "xfce4-power-manager"
run "blueberry-tray"
/usr/lib/xfce4/notifyd/xfce4-notifyd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/emacs --daemon &
run "nextcloud"
run "caffeine"
run "kdeconnect-indicator"
# teams &
# zoom &
# slack &
# whatsdesk &
