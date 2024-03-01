#!/bin/bash


# Config.json file
CONFIG="config/config.json"

# Help file
HELP="./HELPME.txt"

# Retrieves api key from config.json
KEY=$(jq -r '.api_key' $CONFIG)

# Retrieves city name from config.json
CITY=$(jq -r '.city' $CONFIG)

# Retrieves unit type from config.json
UNITS=$(jq -r '.units' $CONFIG)

# Retrieves clear terminal configuration 1 for yes 0 for no
CLEAR_CONFIG=$(jq -r '.clear_terminal' $CONFIG)

# Retrieves show units configuration
SHOW_CONFIG=$(jq -r '.show_units' $CONFIG)

# Retrieves verbos configuration
VERBOSE_CONFIG=$(jq -r '.verbose' $CONFIG)

# Url to openweathermap api
URL="https://api.openweathermap.org/data/2.5/weather?q=${CITY}&units=${UNITS}&appid=${KEY}"

# http response
RESPONSE=$(curl -s "${URL}")

# http status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${URL}")

# Check the http status is a success or 200
if [ $STATUS -eq 200 ];then

# Clear terminal before showing output.
# Clear terminal is 1
if [ $CLEAR_CONFIG -eq 1 ];then
clear

fi

# Welcome message
# Verbose is 1
if [ $VERBOSE_CONFIG -eq 1 ];then
echo -e "Welcome. The weather data provided was taken from Openweathermap current weather API.\n"

fi

# Parse the data set
TEMP=$(echo "${RESPONSE}" | jq -r '.main.temp')
FEELS_LIKE=$(echo "${RESPONSE}" | jq -r '.main.feels_like')
MAX=$(echo "${RESPONSE}" | jq -r '.main.temp_max')
MIN=$(echo "${RESPONSE}" | jq -r '.main.temp_min')
HUMIDITY=$(echo "${RESPONSE}" | jq -r '.main.humidity')
PRESSURE=$(echo "${RESPONSE}" | jq -r '.main.pressure')

WEATHER=$(echo "${RESPONSE}" | jq -r '.weather[0].description')

LON=$(echo "${RESPONSE}" | jq -r '.coord.lon')
LAT=$(echo "${RESPONSE}" | jq -r '.coord.lat')

RAIN=$(echo "${RESPONSE}" | jq -r '.rain."1h"')

# Check ${RAIN} variable is null and set it equal to 0.
if [ "${RAIN}" == "null" ];then
RAIN=0
fi

SPEED=$(echo "${RESPONSE}" | jq -r '.wind.speed')
DEG=$(echo "${RESPONSE}" | jq -r '.wind.deg')

NAME=$(echo "${RESPONSE}" | jq -r '.name')

CLOUDS=$(echo "${RESPONSE}" | jq -r '.clouds.all')

# If it fails to connect to the API.
else

echo -e "http request failed.\nCheck internet connectivity.\nCheck API KEY is correct.\nCheck the config setting are correct in 'config.json'."

exit 1

fi


# Units.

# Show units is 1
if [ $SHOW_CONFIG -eq 1 ];then
if [ "${UNITS}" == "metric" ];then
units="metric"
temp_units=" degees Celcius"
dir_units=" degrees"
vel_units="m/s"
dist_units="m"
small_dist_units="mm"

elif [ "${UNITS}" == "imperial" ];then
units="imperial"
temp_units=" degrees Fahrenheit"
dir_units=" degrees"
vel_units="mph"
dist_units="m"
small_dist_units="mm"

elif [ "${UNITS}" == "standard" ];then
units="Standard (tempurature is in Kelvin)"
temp_units=" Kelvin"
dir_units=" degrees"
vel_units="m/s"
dist_units="m"
small_dist_units="mm"
fi

# Show units is 0
else
temp_units=""
dir_units=""
vel_units=""
dist_units=""
small_dist_units=""

fi

# Check if $1 and $2 are empty or not.
if [ -z "$1" ] && [ -z "$2" ]; then

# Returns all the data:

	# unit of measurement.
	# Location name.
	# Coordinates: (Longitude, Latitude)
	# Temperature data: (current, feels like, maximum, minimum)
	# Humidity (measured in %)
	# Description (weather type)
	# Rain (measured in mm)
	# Wind (speed, direction)
	# Clouds (measured in %)

echo -e "Weather data in the ${UNITS} system.\n"
echo -e "Location:\n\t${NAME}"
echo -e "Coordinates:\n\tlongitude: ${LON}\n\tlatitude: ${LAT}"
echo -e "Dsecription:\n\t${WEATHER}"
echo -e "Temperature:\n\tcurrent: ${TEMP}${temp_units}\n\tfeels_like: ${FEELS_LIKE}${temp_units}"
echo -e "Max/Min temperature:\n\tmax: ${MAX}${temp_units}\n\tmin: ${MIN}${temp_units}"
echo -e "Humidity:\n\t${HUMIDITY}%"
echo -e "Pressure:\n\t${PRESSURE}hPa"
echo -e "Rain:\n\t${RAIN}${small_dist_units}"
echo -e "Wind:\n\tspeed: ${SPEED}${vel_units}\n\tdirection: ${DEG}${dir_units}"
echo -e "Clouds:\n\t${CLOUDS}%\n"

else

# Check if $1 is `-n` and outputs the name of the City or Country.
if [ "$1" == "-n" ];then
echo -e "${NAME}"

# Check if $1 is `-l` and outputs the longitude and latitude of the configured location.
elif [ "$1" == "-l" ];then
echo -e "longitude: ${LON}\nlatitude: ${LAT}"

# Check if $1 is `-t` and outputs the temperature data.
elif [ "$1" == "-t" ] && [ -z "$2" ];then
echo -e "current: ${TEMP}${temp_units}\nfeels_like: ${FEELS_LIKE}${temp_units}"
echo -e "max: ${MAX}${temp_units}\nmin: ${MIN}${temp_units}"

# Check if $1 is `-t` and $2 is not empty.
elif [ "$1" == "-t" ] && [ ! -z "$2" ];then

# Check if $2 is `-c` and ouputs the current temperature.
if [ "$2" == "-c" ];then
echo "${TEMP}${temp_units}"

# feels like temperature
elif [ "$2" == "-f" ];then
echo "${FEELS_LIKE}${temp_units}"

# maximum temperature
elif [ "$2" == "-max" ];then
echo "${MAX}${temp_units}"

# minimum temperature
elif [ "$2" == "-min" ];then
echo "${MIN}${temp_units}"

else
echo -e "Error: $2 is an invalid operand.\nEnter 'weather --help' for more information."

exit 1

fi

# humidity
elif [ "$1" == "-h" ];then
echo "${HUMIDITY}%"

# atmospheric pressure
elif [ "$1" == "-p" ];then
echo "${PRESSURE}hPa"

# description
elif [ "$1" == "-d" ];then
echo "${WEATHER}"

# rainfall
elif [ "$1" == "-r" ];then
echo "${RAIN}${small_dist_units}"

# wind info
elif [ "$1" == "-w" ] && [ -z "$2" ];then
echo -e "${SPEED}${vel_units}\n${DEG}${dir_units}"

# Check if $1 is `-w` and $2 is not empty
elif [ "$1" == "-w" ] && [ ! -z "$2" ];then

# wind speed
if [ "$2" == "-s" ];then
echo "${SPEED}${vel_units}"

# wind direction
elif [ "$2" == "-d" ];then
echo "${DEG}${dir_units}"

else
echo "Error: $2 is an invalid operand.\nEnter 'weather --help' for more information."

fi

# Cloudiness
elif [ "$1" == "-c" ];then
echo "${CLOUDS}%"

# Request help guide
elif [ "$1" == "--help" ];then

cat $HELP

else
echo -e "Error: $1 is an invalid operand.\nEnter 'weather --help' for more information."

exit 1

fi

fi


exit 0


