#!/bin/bash

# Get current brightness using a more reliable method
BRIGHTNESS=$(osascript -e 'tell application "System Events" to get value of slider 1 of group 1 of tab group 1 of window 1 of process "System Settings"' 2>/dev/null || echo "0.5")

# Convert to percentage (brightness is 0-1, multiply by 100)
BRIGHTNESS_PERCENT=$(echo "$BRIGHTNESS * 100" | bc -l | cut -d. -f1)

# Show brightness percentage
sketchybar --set $NAME label="$BRIGHTNESS_PERCENT%" 