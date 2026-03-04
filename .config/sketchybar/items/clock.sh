#!/usr/bin/env bash

COLOR="$MAIN"

sketchybar --add item clock right \
	--set clock update_freq=1 \
	icon.padding_left=10 \
	icon.color="$ACCENT" \
	icon="" \
	label.color="$COLOR" \
	label.padding_right=4 \
	label.width=52 \
	align=center \
	background.height=24 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=4 \
	background.border_color="$COLOR" \
	background.color="$NEUTRAL" \
	background.drawing=on \
	script="$PLUGIN_DIR/clock.sh"
