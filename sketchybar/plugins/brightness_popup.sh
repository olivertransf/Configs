#!/bin/bash

# Check if this is a slider click
if [ "$SENDER" = "mouse.clicked" ] && [ "$NAME" = "brightness_slider" ]; then
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
    
    # Update the popup info
    sketchybar --set brightness_popup_info label="Brightness: $BRIGHTNESS_PERCENT%"
    exit 0
fi

# Get current brightness using a simpler method
BRIGHTNESS=$(osascript -e 'tell application "System Events" to get value of slider 1 of group 1 of tab group 1 of window 1 of process "System Settings"' 2>/dev/null || echo "0.5")

# Convert to percentage
BRIGHTNESS_PERCENT=$(echo "$BRIGHTNESS * 100" | bc -l | cut -d. -f1)

# Show popup with brightness slider
sketchybar --set brightness popup.drawing=on \
           --set brightness popup.background.color=0xff000000 \
           --set brightness popup.background.border_color=0xffffffff \
           --set brightness popup.background.border_width=1 \
           --set brightness popup.background.corner_radius=5 \
           --set brightness popup.background.blur_radius=10 \
           --set brightness popup.align=center \
           --set brightness popup.y_offset=5

# Add popup item with brightness info
sketchybar --add item brightness_popup_info popup.brightness \
           --set brightness_popup_info label="Brightness: $BRIGHTNESS_PERCENT%" \
           --set brightness_popup_info label.color=0xffffffff \
           --set brightness_popup_info label.font="Hack Nerd Font:Regular:12.0" \
           --set brightness_popup_info label.padding_left=10 \
           --set brightness_popup_info label.padding_right=10 \
           --set brightness_popup_info label.padding_top=5 \
           --set brightness_popup_info label.padding_bottom=5

# Add proper slider
sketchybar --add slider brightness_slider popup.brightness 150 \
           --set brightness_slider slider.percentage=$BRIGHTNESS_PERCENT \
           --set brightness_slider slider.highlight_color=0xffffffff \
           --set brightness_slider slider.background.color=0xff333333 \
           --set brightness_slider slider.background.corner_radius=3 \
           --set brightness_slider slider.knob="●" \
           --set brightness_slider slider.knob.color=0xffffffff \
           --set brightness_slider slider.knob.font="Hack Nerd Font:Regular:8.0" \
           --set brightness_slider label.padding_left=10 \
           --set brightness_slider label.padding_right=10 \
           --set brightness_slider label.padding_top=5 \
           --set brightness_slider label.padding_bottom=5 \
           --subscribe brightness_slider mouse.clicked

# Hide popup after 5 seconds
sleep 5
sketchybar --set brightness popup.drawing=off
sketchybar --remove item brightness_popup_info
sketchybar --remove item brightness_slider 