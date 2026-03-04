#!/usr/bin/env bash

COLOR="$MAIN"

sketchybar --add item cpu right \
	--set cpu \
	update_freq=3 \
	icon.color="$ACCENT" \
	icon.padding_left=10 \
	label.color="$COLOR" \
	label.padding_right=10 \
	background.height=24 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_light=4 \
	background.border_color="$COLOR" \
	background.color="$NEUTRAL" \
	background.drawing=on \
	script="$PLUGIN_DIR/cpu.sh"
