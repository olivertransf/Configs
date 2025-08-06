#!/bin/bash

# Get current media info
if pgrep -x "Spotify" > /dev/null; then
  TRACK_INFO=$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null)
  ARTIST_INFO=$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null)
  PLAYER_STATE=$(osascript -e 'tell application "Spotify" to get player state as string' 2>/dev/null)
  
  if [ "$PLAYER_STATE" = "playing" ] && [ -n "$TRACK_INFO" ]; then
    # Show popup with current track info
    sketchybar --set media popup.drawing=on \
               --set media popup.background.color=0xff000000 \
               --set media popup.background.border_color=0xffffffff \
               --set media popup.background.border_width=1 \
               --set media popup.background.corner_radius=5 \
               --set media popup.background.blur_radius=10 \
               --set media popup.align=center \
               --set media popup.y_offset=5
    
    # Add popup item with track info
    sketchybar --add item media_popup_info popup.media \
               --set media_popup_info label="$TRACK_INFO - $ARTIST_INFO" \
               --set media_popup_info label.color=0xffffffff \
               --set media_popup_info label.font="Hack Nerd Font:Regular:12.0" \
               --set media_popup_info label.padding_left=10 \
               --set media_popup_info label.padding_right=10 \
               --set media_popup_info label.padding_top=5 \
               --set media_popup_info label.padding_bottom=5
    
    # Hide popup after 3 seconds
    sleep 3
    sketchybar --set media popup.drawing=off
    sketchybar --remove item media_popup_info
  else
    # Show "Not Playing" popup
    sketchybar --set media popup.drawing=on \
               --set media popup.background.color=0xff000000 \
               --set media popup.background.border_color=0xffffffff \
               --set media popup.background.border_width=1 \
               --set media popup.background.corner_radius=5 \
               --set media popup.background.blur_radius=10 \
               --set media popup.align=center \
               --set media popup.y_offset=5
    
    # Add popup item
    sketchybar --add item media_popup_info popup.media \
               --set media_popup_info label="Not Playing" \
               --set media_popup_info label.color=0xffffffff \
               --set media_popup_info label.font="Hack Nerd Font:Regular:12.0" \
               --set media_popup_info label.padding_left=10 \
               --set media_popup_info label.padding_right=10 \
               --set media_popup_info label.padding_top=5 \
               --set media_popup_info label.padding_bottom=5
    
    # Hide popup after 2 seconds
    sleep 2
    sketchybar --set media popup.drawing=off
    sketchybar --remove item media_popup_info
  fi
else
  # Show "Spotify not running" popup
  sketchybar --set media popup.drawing=on \
             --set media popup.background.color=0xff000000 \
             --set media popup.background.border_color=0xffffffff \
             --set media popup.background.border_width=1 \
             --set media popup.background.corner_radius=5 \
             --set media popup.background.blur_radius=10 \
             --set media popup.align=center \
             --set media popup.y_offset=5
  
  # Add popup item
  sketchybar --add item media_popup_info popup.media \
             --set media_popup_info label="Spotify Not Running" \
             --set media_popup_info label.color=0xffffffff \
             --set media_popup_info label.font="Hack Nerd Font:Regular:12.0" \
             --set media_popup_info label.padding_left=10 \
             --set media_popup_info label.padding_right=10 \
             --set media_popup_info label.padding_top=5 \
             --set media_popup_info label.padding_bottom=5
  
  # Hide popup after 2 seconds
  sleep 2
  sketchybar --set media popup.drawing=off
  sketchybar --remove item media_popup_info
fi 