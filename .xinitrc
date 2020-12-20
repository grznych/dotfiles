#!/bin/sh
xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
[ -x "$f" ] && . "$f" ; done ; unset f ; fi

export CM_LAUNCHER=rofi PATH+=:$HOME/.local/bin VISUAL=gedit

setxkbmap ruf "" grp_led:caps -print | xkbcomp -I$HOME/.config/xkb - $DISPLAY &

{ geh; glock; } & xxkb & redshift & urxvtd -q -o -f &

#xrandr --output HDMI-0 --left-of LVDS &
#xrandr --output HDMI-0 --mode 1360x768 --same-as LVDS &

exec i3
#exec bspwm
