#!/bin/bash

# Start yabai using the proper launchctl method
echo "Starting yabai..."

# Start the yabai service
launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"

# Wait a moment for yabai to start
sleep 2

# Load the scripting addition
echo "Loading scripting addition..."
sudo yabai --load-sa

# Wait a moment for scripting addition to load
sleep 1

# Run the configuration script
echo "Applying yabai configuration..."
bash /Users/olivertran/.config/yabai/yabairc

echo "yabai startup complete"
