#!/bin/bash
# toggle hdmi/lvds monitor on/off, triggered by udev

HDMI1_CONNECTED=$(xrandr | grep -c "HDMI1 connected")
HDMI1_ACTIVE=$(xrandr | grep -cE "HDMI1 connected (primary )?[1-9]+")

LVDS1_CONNECTED=$(xrandr | grep -c "LVDS1 connected")
LVDS1_ACTIVE=$(xrandr | grep -cE "LVDS1 connected (primary )?[1-9]+")

# turn on hdmi1 if connected but not active
if [[ $HDMI1_CONNECTED -eq 1 && $HDMI1_ACTIVE -eq 0 ]]; then toggle-monitor HDMI1; fi

# turn on laptop if hdmi isn't active
if [[ $HDMI1_CONNECTED -eq 0 && $LVDS1_ACTIVE -eq 0 ]]; then toggle-monitor LVDS1; fi
