#!/bin/bash

# This script checks network status by directly checking active interfaces
# instead of iterating through all network services.

# Get the default route interface (the one currently being used for internet)
DEFAULT_INTERFACE=$(route -n get default | awk '/interface:/ {print $2}')

# Check if we have a default interface
if [[ -n "$DEFAULT_INTERFACE" ]]; then
  # Get the Wi-Fi interface name
  WIFI_DEVICE=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')

  # Check if the default interface is Wi-Fi
  if [[ "$DEFAULT_INTERFACE" == "$WIFI_DEVICE" ]]; then
    # It's Wi-Fi - get SSID if available
    SSID=$(ipconfig getsummary "$DEFAULT_INTERFACE" | awk -F' SSID : ' '/ SSID : / {print $2}')
    ICON="󰖩"
  else
    # It's a wired connection (Ethernet, USB, Thunderbolt, etc.)
    ICON="󰈀"
  fi

  # Update Sketchybar with the appropriate icon
  sketchybar --set $NAME icon="$ICON"
else
  # No default route found - we are disconnected
  ICON="󰖪"
  sketchybar --set $NAME icon="$ICON"
fi
