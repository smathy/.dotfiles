#!/bin/bash
export RELPATH=$(dirname $0)/../..
source $RELPATH/log_handler.sh

## Private function

# Updates time precisely
update() {
  sketchybar --set $NAME icon="$(date '+%a %b %d')" label="$(date '+%H:%M:%S %V')"
	sendLog "Updated date" "vomit"
}

## Main logic
update
