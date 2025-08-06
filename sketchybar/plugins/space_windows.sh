#!/bin/bash

# Get the space number from the script name (space.1, space.2, etc.)
space=$(echo "$NAME" | sed 's/space\.//')

# Check if there are any windows on this space using yabai
window_count=$(yabai -m query --spaces --space "$space" | jq '.windows | length')

icon_strip=" "
if [ "$window_count" -gt 0 ]; then
  icon_strip=" •"
else
  icon_strip=" —"
fi

sketchybar --set "$NAME" label="$icon_strip"
