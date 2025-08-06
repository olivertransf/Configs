#!/bin/bash

# Check if this is a slider click
if [ "$SENDER" = "mouse.clicked" ] && [ "$NAME" = "volume_slider" ]; then
    # Set volume based on click percentage
    osascript -e "set volume output volume $PERCENTAGE"
    
    # Update the volume display immediately
    VOLUME=$(osascript -e 'output volume of (get volume settings)')
    sketchybar --set volume label="$VOLUME%"
    
    # Also update the slider percentage
    sketchybar --set volume_slider slider.percentage=$PERCENTAGE
    
    # Update the popup info
    sketchybar --set volume_popup_info label="Volume: $VOLUME%"
    exit 0
fi

# Get current volume
CURRENT_VOLUME=$(osascript -e 'output volume of (get volume settings)')

# Show popup with volume slider
sketchybar --set volume popup.drawing=on \
           --set volume popup.background.color=0xff000000 \
           --set volume popup.background.border_color=0xffffffff \
           --set volume popup.background.border_width=1 \
           --set volume popup.background.corner_radius=5 \
           --set volume popup.background.blur_radius=10 \
           --set volume popup.align=center \
           --set volume popup.y_offset=5

# Add popup item with volume info
sketchybar --add item volume_popup_info popup.volume \
           --set volume_popup_info label="Volume: $CURRENT_VOLUME%" \
           --set volume_popup_info label.color=0xffffffff \
           --set volume_popup_info label.font="Hack Nerd Font:Regular:12.0" \
           --set volume_popup_info label.padding_left=10 \
           --set volume_popup_info label.padding_right=10 \
           --set volume_popup_info label.padding_top=5 \
           --set volume_popup_info label.padding_bottom=5

# Add proper slider
sketchybar --add slider volume_slider popup.volume 150 \
           --set volume_slider slider.percentage=$CURRENT_VOLUME \
           --set volume_slider slider.highlight_color=0xffffffff \
           --set volume_slider slider.background.color=0xff333333 \
           --set volume_slider slider.background.corner_radius=3 \
           --set volume_slider slider.knob="●" \
           --set volume_slider slider.knob.color=0xffffffff \
           --set volume_slider slider.knob.font="Hack Nerd Font:Regular:8.0" \
           --set volume_slider label.padding_left=10 \
           --set volume_slider label.padding_right=10 \
           --set volume_slider label.padding_top=5 \
           --set volume_slider label.padding_bottom=5 \
           --subscribe volume_slider mouse.clicked

# Hide popup after 5 seconds
sleep 5
sketchybar --set volume popup.drawing=off
sketchybar --remove item volume_popup_info
sketchybar --remove item volume_slider 