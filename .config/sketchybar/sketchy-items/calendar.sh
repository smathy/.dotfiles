#!/bin/bash

## Scripts
SCRIPT_CALENDAR="export PATH=$PATH; $RELPATH/plugins/calendar/script.sh"
SCRIPT_CLICK_CALENDAR="export PATH=$PATH; $RELPATH/plugins/calendar/click.sh"

calendar=(
  icon="$(date '+%a %b %d')"
  label="$(date '+%H:%M:%S %V')"
  icon.font="$FONT:Black:12.0"
  icon.padding_right=0
  label.width=90
  label.align=center
  label.padding_right=0
  update_freq=1
  script="$SCRIPT_CALENDAR"
)

sketchybar --add item calendar right --set calendar "${calendar[@]}"

add_separator "0" "right"

sendLog "Added calendar (date) item" "vomit"
