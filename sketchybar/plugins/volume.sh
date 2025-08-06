#!/bin/bash

# Get current volume
VOLUME=$(osascript -e 'output volume of (get volume settings)')

# Show volume icon and percentage
sketchybar --set $NAME label="$VOLUME%"
