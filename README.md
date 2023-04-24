# Weather-api-Openweathermap-bash

Writen in Linux Ubuntu 20.04.2 LTS.

This App is design to be used in the bash terminal. 
Provides information on weather data taken from "https://openweathermap.org/".
Provides weather data at a given location.

# Output

1. Name of the location.
2. Coordinates (longitude and latitude) (degrees meteorological)
3. Temperature (Standard Kelvin, Metric degrees Celcius and Imperial Fahrenheit): Current temperature, Feels like, Maximum temperature and the Minimum temperature.
4. Humidity (%)
5. Pressure (hPa)
6. Description.
7. Rainfall (mm)
8. Wind:
- Wind Speed (Standard and Metric m/s, Imperial mph)
- Direction (degrees meteorological) 
9. Cloudiness (%)

# Usage

**NOTE**: Please ensure the config.json is configured with the proper settings.

Once an account was created and also subscribed to the "Current Weather Data" API then,
API keys can be found using the following link: "https://home.openweathermap.org/api_keys/".


{
	"city": "YOUR_LOCATION",
	"units": "YOUR_UNITS",
	"api_key": "YOUR_API_KEY",
	"clear_terminal": 0,
  	"show_units": 0,
  	"verbose": 0
}


Enter the following int othe terminal to configure these settings:

	bash config/weather-config [OPTIONS]

-c To configure a location.

-u To configure a unit of measurement (standard, metric, imperial)

-k To configure an API key.

-clear To configure the clear terminal setting (on by default)

-show-units To configure the show units setting (on by defalt) if off the units will not appear beside the quantity printed in the terminal.

-verbose To switch on and off the welcome message printed when the program begins running (on by default)

-r Read out all the configurations in the terminal.

Enter the following into the terminal:

	bash weather [OPTIONS1] [OPTIONS2]

## OPTIONS

**NOTE**: Only the temperature and wind fields require an extra optional flag. 

-n Get the Name at configured location.

-l Get the coordinated at the configured location.

-t Get all temperature data at the location.

-t -c Get current temperature.
	
-t -f Get tge feels like temperature.
	
-t -max Get the maximum temperature.
	
-t -min Get the minimum temperature.
	
-h Get the humidity of the configured location.

-p Get the atmospheric pressure of the configured location.

-d Get the description of the weather at the configured location.

-r Get the rainfall measurement at the configured location.

-w Get all wind data at the configured location.

-w -s Get the wind speed at the configured location.
	
-w -d Get the wind direction at the configured location.
	
-c Get the cloudiness at the configured location. 

--help Get the help guide.

