#!/usr/bin/env bash

COLOR="$MAIN"

sketchybar \
	--add item front_app left \
	--set front_app script="$PLUGIN_DIR/front_app.sh" \
	icon.drawing=on \
	background.height=24 \
	background.padding_left=0 \
	background.padding_right=10 \
	background.border_color="$COLOR" \
	background.corner_radius="$CORNER_RADIUS" \
	label.color="$WHITE" \
  label.font="$FONT:Bold:18.0" \
	label.shadow.drawing=on \
	label.shadow.color=0x44000000 \
	label.shadow.angle=90 \
	label.shadow.distance=2 \
	label.padding_left=10 \
	label.padding_right=10 \
	associated_display=active \
	--subscribe front_app front_app_switched
