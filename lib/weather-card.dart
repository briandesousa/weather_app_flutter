import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/weather-data.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;
  final Function onTap;

  WeatherCard({Key key, @required this.weatherData, @required this.onTap})
      : super(key: key);

  Widget buildLocation(String location) {
    return Text(
      location != null ? location : '',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildTemperature(String temperature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        temperature != null ? temperature : '',
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  Widget buildWeatherDescription(String weatherDescription) {
    return Text(
      weatherDescription != null ? weatherDescription : '',
      style: TextStyle(fontSize: 14.0),
    );
  }

  Widget buildRefreshIcon() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Icon(
        Icons.refresh,
        size: 45,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      buildLocation(weatherData.location),
                      buildTemperature(weatherData.temperature),
                      buildWeatherDescription(weatherData.weatherDescription),
                      buildRefreshIcon(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
