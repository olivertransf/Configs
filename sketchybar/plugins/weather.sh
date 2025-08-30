#!/bin/sh

# Weather plugin for sketchybar
# You'll need to get a free API key from https://openweathermap.org/api

# Replace YOUR_API_KEY with your actual OpenWeatherMap API key
API_KEY="YOUR_API_KEY"
CITY="London"  # Change this to your city
UNITS="metric"  # metric for Celsius, imperial for Fahrenheit

# Get weather data
WEATHER_DATA=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=${UNITS}")

if [ $? -eq 0 ]; then
    # Extract temperature and weather description
    TEMP=$(echo "$WEATHER_DATA" | jq -r '.main.temp' 2>/dev/null)
    WEATHER=$(echo "$WEATHER_DATA" | jq -r '.weather[0].main' 2>/dev/null)
    
    if [ "$TEMP" != "null" ] && [ "$WEATHER" != "null" ]; then
        # Round temperature to nearest integer
        TEMP_ROUNDED=$(printf "%.0f" "$TEMP")
        
        # Set weather icon based on conditions
        case "$WEATHER" in
            "Clear") ICON="☀️" ;;
            "Clouds") ICON="☁️" ;;
            "Rain") ICON="🌧️" ;;
            "Snow") ICON="❄️" ;;
            "Thunderstorm") ICON="⛈️" ;;
            "Drizzle") ICON="🌦️" ;;
            "Mist"|"Fog") ICON="🌫️" ;;
            *) ICON="🌤️" ;;
        esac
        
        # Update sketchybar
        sketchybar --set "$NAME" icon="$ICON" label="${TEMP_ROUNDED}°C"
    else
        sketchybar --set "$NAME" icon="❓" label="N/A"
    fi
else
    sketchybar --set "$NAME" icon="❓" label="Error"
fi
