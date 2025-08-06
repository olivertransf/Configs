#!/bin/bash

# Convert percentage to decimal (0-1)
BRIGHTNESS_DECIMAL=$(echo "scale=2; $PERCENTAGE / 100" | bc)

# Set brightness using a more reliable method
osascript -e "tell application \"System Events\" to set value of slider 1 of group 1 of tab group 1 of window 1 of process \"System Settings\" to $BRIGHTNESS_DECIMAL" 2>/dev/null

# Update the brightness display immediately
BRIGHTNESS=$(osascript -e 'tell application "System Events" to get value of slider 1 of group 1 of tab group 1 of window 1 of process "System Settings"' 2>/dev/null || echo "0.5")
BRIGHTNESS_PERCENT=$(echo "$BRIGHTNESS * 100" | bc -l | cut -d. -f1)
sketchybar --set brightness label="$BRIGHTNESS_PERCENT%"

# Also update the slider percentage
sketchybar --set brightness_slider slider.percentage=$PERCENTAGE 