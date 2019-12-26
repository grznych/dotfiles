#!/bin/sh

xrdb -merge ~/.Xresources
xkbcomp -w0 ~/.Xkeymap $DISPLAY

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export CM_LAUNCHER=rofi
PATH+=:$HOME/.local/bin

{ ~/.fehbg; glock; } & xxkb & redshift & urxvtd -q -o -f &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

#xrandr --output HDMI-0 --left-of LVDS &
#xrandr --output HDMI-0 --mode 1360x768 --same-as LVDS &

exec i3
