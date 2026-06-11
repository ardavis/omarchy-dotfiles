#!/bin/bash
CURRENT=$(wpctl inspect @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep "node.description" | head -1 | sed 's/.*= "//;s/"//')

if [[ "$CURRENT" == *"Razer"* ]]; then
  echo '{"text": "󰋋", "tooltip": "Audio: Razer Kraken V4\nClick to switch to Speakers", "class": "headset"}'
else
  echo '{"text": "󰓃", "tooltip": "Audio: Speakers\nClick to switch to Razer Kraken", "class": "speakers"}'
fi
