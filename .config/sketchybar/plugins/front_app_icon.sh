#!/bin/sh

# Front app icon only 
# Some events send additional information specific to the event in the $INFO
if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")"
fi
