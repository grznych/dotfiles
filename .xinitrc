#!/bin/sh

#userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

#[[ -f $sysresources ]] && xrdb -merge $sysresources
#[[ -f $sysmodmap ]] && xmodmap $sysmodmap
#[[ -f "$userresources" ]] && xrdb -merge "$userresources"
#[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

# start some nice programs

xrdb -merge $HOME/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export CM_LAUNCHER=rofi
PATH+=:$HOME/.local/bin

{ ~/.fehbg; glock; } &
xxkb &
redshift &
urxvtd -q -o -f &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

#xrandr --output HDMI-0 --mode 1360x768 --same-as LVDS &
#setxkbmap "pl,ru_fix" "" "grp:caps_toggle,grp_led:caps" &
#compton &

exec i3
