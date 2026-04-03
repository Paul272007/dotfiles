#!/bin/bash

# SETTINGS
APIKEY=$(cat "$HOME/.owm-key")
CITY_NAME='Ifs'
COUNTRY_CODE='FR'
WEATHER_LANG="fr"
UNITS="metric"
THEME=$(cat ~/.cache/current_theme)

if [ "$THEME" == "hyprland" ]; then
  COLOR="#89b4fa"
elif [[ "$THEME" == "mountain" ]]; then
  COLOR="#F87C63"
else
  COLOR="#ffffff"
fi

# API Call
URL="https://api.openweathermap.org/data/2.5/weather?appid=$APIKEY&units=$UNITS&lang=$WEATHER_LANG&q=$CITY_NAME,${COUNTRY_CODE}"
RESPONSE=$(curl -s "$URL")

# Vérification d'erreur
if [ -z "$RESPONSE" ] || [ "$(echo "$RESPONSE" | jq -r .cod)" != "200" ]; then
  echo "{ \"text\": \" 󰇸\", \"tooltip\": \"Météo indisponible\", \"class\": \"weather\" }"
  exit 0
fi

# Extract Data
WID=$(echo "$RESPONSE" | jq -r .weather[0].id)
TEMP=$(echo "$RESPONSE" | jq -r .main.temp | awk '{print int($1+0.5)}') # Arrondi propre
SUNRISE=$(echo "$RESPONSE" | jq -r .sys.sunrise)
SUNSET=$(echo "$RESPONSE" | jq -r .sys.sunset)
DATE=$(date +%s)

# Determine Weather Icon
function setIcons {
  if [ "$WID" -le 232 ]; then
    # Thunderstorm
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -le 311 ]; then
    # Light drizzle
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -le 321 ]; then
    # Heavy drizzle
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -le 531 ]; then
    # Rain
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -le 622 ]; then
    # Snow
    ICON=" "
  elif [ "$WID" -le 771 ]; then
    # Fog
    ICON=" "
  elif [ "$WID" -eq 781 ]; then
    # Tornado
    ICON=""
  elif [ "$WID" -eq 800 ]; then
    # Clear sky
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -eq 801 ]; then
    # Few clouds
    if [ "$DATE" -ge "$SUNRISE" -a "$DATE" -le "$SUNSET" ]; then ICON=" "; else ICON=" "; fi
  elif [ "$WID" -le 804 ]; then
    # Overcast
    ICON=" "
  else
    ICON=""
  fi
}

setIcons

# Icône thermomètre (On la définit car elle était vide dans ton echo)
TEMP_ICON="󰔏"

# Output JSON pour Waybar
# J'ai mis le nuage à 130% pour qu'il soit bien visible comme tu le voulais
echo "{ \"text\": \"<span color='${COLOR}' size='125%'>${ICON}</span> <span>${TEMP_ICON} ${TEMP}°C</span>\", \"tooltip\": \"Météo: ${TEMP}°C\", \"class\": \"weather\" }"
