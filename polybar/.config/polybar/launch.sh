#!/bin/bash

# Debugging: Log to a file to check if the script is executed
echo "$(date) - Polybar launch script executed" >>/tmp/polybar-launch.log

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Wait a bit before launching Polybar (useful if there's a timing issue)
sleep 2

# Set DISPLAY environment variable
export DISPLAY=:0

# Launch Polybar
polybar &

echo "$(date) - Polybar launched" >>/tmp/polybar-launch.log
