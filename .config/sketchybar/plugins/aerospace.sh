#!/usr/bin/env bash 
source "$CONFIG_DIR/colors.sh"

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# Get the current focused workspace
# FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$1" = "$FOCUSED" ]; then
    sketchybar --set $NAME background.drawing=on \
                          label.color=$TEXT_COLOR \
                         # background.color=$ITEM_BG_COLOR \
                         # label.color=0xff070707
                         # background.color=0xff008c39 \
                         # background.color=0xff9dd274 \
else
    sketchybar --set $NAME background.drawing=off \
                          label.color=$WHITE
                         # label.color=0xff777B92
fi
