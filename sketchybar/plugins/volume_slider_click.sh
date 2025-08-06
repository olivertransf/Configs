#!/bin/bash

# Set volume based on click percentage
osascript -e "set volume output volume $PERCENTAGE"

# Update the volume display immediately
VOLUME=$(osascript -e 'output volume of (get volume settings)')
sketchybar --set volume label="$VOLUME%"

# Also update the slider percentage
sketchybar --set volume_slider slider.percentage=$PERCENTAGE 