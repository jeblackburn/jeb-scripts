#!/bin/bash -x

# screen width (the effective resolution! just set yours here.)
screen_width1=1440
screen_width2=1484

# active window
window=`xdotool getactivewindow`

# get active window size and position
x=`xwininfo -id $window | grep "Absolute upper-left X" | awk '{print $4}'`
w=`xwininfo -id $window | grep "Width" | awk '{print $2}'`

maximized=false

# window on left monitor
if [ "$x" -lt "$screen_width1" ]; then
    if [ "$w" -eq "$screen_width1" ]; then
        maximized=true
    fi

    if $maximized; then
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    fi

    wmctrl -r :ACTIVE: -e 0,$screen_width1,-1,-1,-1

    if $maximized; then
        wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
    fi

# window on right monitor
else
    if [ "$w" -eq "$screen_width2" ]; then
        maximized=true
    fi

    if $maximized; then
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    fi

    wmctrl -r :ACTIVE: -e 0,0,-1,-1,-1

    if $maximized; then
        wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
    fi
fi
