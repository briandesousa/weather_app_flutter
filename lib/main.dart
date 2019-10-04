import 'package:flutter/material.dart';
import 'package:flutter_weather/weather-card.dart';
import 'package:flutter_weather/weather-data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var title = 'Weather';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cardColor: Colors.lightGreen[200],
        splashColor: Colors.green[700].withAlpha(100),
      ),
      home: Home(title: title),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  WeatherData _weatherData = WeatherData();

  Widget buildCityLabel() {
    return Text(
      'Select a city to view the weather',
      style: TextStyle(fontSize: 20.0),
    );
  }

  Widget buildCityFormField() {
    return DropdownButton<String>(
      value: _weatherData.location,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 26,
      ),
      underline: Container(
        height: 2,
        color: Colors.black87,
      ),
      items: <String>[
        'London, ON',
        'Toronto, ON',
        'New York, NY',
        'London, Engalnd'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          this._weatherData.location = newValue;
        });
      },
    );
  }

  fetchWeatherData({String location = 'London, ON'}) {
    // initiate Weather API call here instead of mock data
    var currentSeconds = DateTime.now().second;
    var weather = WeatherData();
    weather.location = location;

    // simulate changing weather based on seconds on the clock
    weather.weatherDescription =
        currentSeconds % 2 == 0 ? 'partly cloudy' : 'sunny';
    weather.temperature = '${currentSeconds / 2}\u2103';

    this._weatherData = weather;
  }

  @override
  initState() {
    super.initState();
    setState(() {
      fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCityLabel(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: buildCityFormField(),
              ),
              WeatherCard(
                weatherData: _weatherData,
                onTap: () {
                  setState(() {
                    fetchWeatherData();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
