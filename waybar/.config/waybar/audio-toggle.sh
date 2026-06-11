#!/bin/bash
RAZER_NAME="Razer Kraken V4 Analog Stereo"
SPEAKERS_NAME="Ryzen HD Audio Controller Analog Stereo"

# Get current default sink name
CURRENT=$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep "node.description" | head -1 | sed 's/.*= "//;s/"//')

if [ "$CURRENT" = "$RAZER_NAME" ]; then
  TARGET="$SPEAKERS_NAME"
else
  TARGET="$RAZER_NAME"
fi

# Find target sink ID from wpctl status
TARGET_ID=$(wpctl status 2>/dev/null | grep "$TARGET" | grep -oP '\d+(?=\.)' | head -1)

if [ -n "$TARGET_ID" ]; then
  wpctl set-default "$TARGET_ID"
  pkill -RTMIN+11 waybar
fi
