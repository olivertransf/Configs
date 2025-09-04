#!/bin/bash

# Start yabai using the proper launchctl method
echo "Starting yabai..."

# Kill any existing yabai processes
pkill -f yabai

# Start the yabai service
launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"

# Wait a moment for yabai to start
sleep 3

# Load the scripting addition
echo "Loading scripting addition..."
sudo yabai --load-sa

# Wait a moment for scripting addition to load
sleep 2

# Run the configuration script
echo "Applying yabai configuration..."
bash /Users/olivertran/.config/yabai/yabairc

# Verify yabai is running
if pgrep -x "yabai" > /dev/null; then
    echo "yabai startup complete - process running with PID $(pgrep -x yabai)"
else
    echo "ERROR: yabai failed to start"
    exit 1
fi
