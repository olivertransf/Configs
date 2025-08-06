#!/bin/bash

# Check if Spotify is running and playing
if pgrep -x "Spotify" > /dev/null; then
  # Get Spotify track info
  TRACK_INFO=$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null)
  ARTIST_INFO=$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null)
  PLAYER_STATE=$(osascript -e 'tell application "Spotify" to get player state as string' 2>/dev/null)
  
  if [ "$PLAYER_STATE" = "playing" ] && [ -n "$TRACK_INFO" ] && [ -n "$ARTIST_INFO" ]; then
    MEDIA="$TRACK_INFO - $ARTIST_INFO"
    sketchybar --set $NAME label="$MEDIA" drawing=on
  else
    sketchybar --set $NAME drawing=off
  fi
else
  sketchybar --set $NAME drawing=off
fi 