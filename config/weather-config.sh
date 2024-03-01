#!/bin/bash

# Input different Values for each key based on the following flags:
# 1. -c Allows user to configure location with key city where the weather data is measured.
# 2. -u Allows users to specify a unit system "standard", "metric" or "imperial".
# 3. -k Allows user to configure their api key that can be created by creating an account on `https://openweathermap.org/` and subscribing to an API.
# 4. -clear Allows user to turn on and off the clear terminal when launched setting.
# 5. -show-units Allows user to show units or not.
# 6. -verbose allows user to turn on or off the welcome message.

CONFIG="config/config.json"

if [ "$1" == "-c" ];then

echo "location:"
read CITY

jq '(.city) |= "'$CITY'"' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "$1" == "-u" ];then

echo -e "Units systems are:\nstandard (temperature Kelvin, m/s)\nmetric (temperature Degrees Celcius, m/s)\nimperial (temperature Fahrenheit, mph)"

echo "unit system:"
read UNITS

jq '(.units) |= "'$UNITS'"' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "$1" == "-k" ];then

echo -e "API key can be found at https://openweathermap.org/.\nCreate and account and subsribe to the API Current 'weather and forecasts collection'."

echo "API key:"
read API_KEY

jq '(.api_key) |= "'$API_KEY'"' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "$1" == "-clear" ];then

echo "Clear terminal when ran. y or leave blank for yes. n for no:"
read CLEAR

if [ -z "${CLEAR}" ] || [ "${CLEAR}" == "y" ];then

jq '(.clear_terminal) |= '1'' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "${CLEAR}" == "n" ];then

jq '(.clear_terminal) |= '0'' $CONFIG > tmp.json && mv tmp.json $CONFIG

else

echo "Invalid input."

exit 1

fi

elif [ "$1" == "-show-units" ];then

echo "Show units with values. y or leave blank for yes. n for no."
read SHOW

if [ -z "${SHOW}" ] || [ "${SHOW}" == "y" ];then

jq '(.show_units) |= '1'' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "${SHOW}" == "n" ];then

jq '(.show_units) |= '0'' $CONFIG > tmp.json && mv tmp.json $CONFIG

else

echo "Invalid input."

exit 1

fi

elif [ "$1" == "-verbose" ];then

echo "Show welcome message when ran. y or leave blank for yes. n for no."
read VERBOSE

if [ -z "${VERBOSE}" ] || [ "${VERBOSE}" == "y" ];then

jq '(.verbose) |= '1'' $CONFIG > tmp.json && mv tmp.json $CONFIG

elif [ "${VERBOSE}" == "n" ];then

jq '(.verbose) |= '0'' $CONFIG > tmp.json && mv tmp.json $CONFIG

else

echo "Invalid input."

exit 1

fi

elif [ "$1" == "-r" ];then

echo "Current settings are:"

echo "Location: $(jq -r '.city' $CONFIG)"
echo "Unit of measurement: $(jq -r '.units' $CONFIG)"
echo "API key: $(jq -r '.api_key' $CONFIG)"
echo "Clear terminal $(jq -r '.clear_terminal' $CONFIG)"
echo "Show units $(jq -r '.show_units' $CONFIG)"
echo "Verbose $(jq -r '.verbose' $CONFIG)"


elif [ -z "$1" ];then

echo -e "Error: Invalid operand.\nEnter 'weather-config --help' for more information."

exit 1

else

echo -e "Error: Invalid operand.\nEnter 'weather-config --help' for more information."

exit 1

fi

exit 0

