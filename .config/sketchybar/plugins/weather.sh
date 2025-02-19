#!/usr/bin/env zsh

LOCATION_JSON=$(curl -s 'https://api.weather.gov/points/30.2858,-98.8698')
LOCATION="$(echo $LOCATION_JSON | jq '.properties.relativeLocation.properties.city' | tr -d '"')"
WEATHER_URL="$(echo $LOCATION_JSON | jq '.properties.forecast' | tr -d '"')"
WEATHER_JSON=$(curl -s $WEATHER_URL | jq '.properties.periods[0]')

# Fallback if empty
if [ -z $WEATHER_JSON ]; then

    sketchybar --set $NAME label=N/A
    sketchybar --set $NAME.moon icon=

    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.temperature' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.shortForecast' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE℉ $WEATHER_DESCRIPTION"
