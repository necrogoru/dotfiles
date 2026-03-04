#!/usr/bin/env bash

COLOR="$MAIN"

sketchybar --add item battery right \
	--set battery \
	update_freq=60 \
	icon.color="$ACCENT" \
	icon.padding_left=10 \
	label.padding_right=10 \
	label.color="$COLOR" \
	background.height=24 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=4 \
	background.border_color="$COLOR" \
	background.color="$NEUTRAL" \
	background.drawing=on \
	script="$PLUGIN_DIR/power.sh" \
	--subscribe battery power_source_change

