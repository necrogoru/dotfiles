#!/bin/bash

COLOR="$MAIN"
network=(
  icon=󰖩
  script="$PLUGIN_DIR/network.sh"
  update_freq=10
)

sketchybar --add item network right \
           --set network "${network[@]}" \
            icon.color="$ACCENT" \
            icon.padding_left=10 \
            icon.padding_right=10 \
            label.drawing=off \
            background.height=24 \
            background.corner_radius="$CORNER_RADIUS" \
            background.padding_right=4 \
            background.border_color="$COLOR" \
            background.color="$NEUTRAL" \
           --subscribe network wifi_change system_woke network_update

# Alternative subscription approach
# sketchybar --subscribe network system_woke
