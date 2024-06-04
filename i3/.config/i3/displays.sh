#!/bin/sh

# Disable monitors to avoid conflicts
xrandr --output HDMI-0 --off --output DP-2 --off --output DP-4 --off

# Set monitor configuration
xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97
xrandr --output DP-4 --mode 1920x1080 --rate 144.00 --right-of HDMI-0 --primary
xrandr --output DP-2 --mode 1920x1080 --rate 74.97 --right-of DP-4
