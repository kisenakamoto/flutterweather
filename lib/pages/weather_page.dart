import 'package:flutter/material.dart';
import 'package:flutterweather/models/weather_model.dart';
import 'package:flutterweather/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('aba6ff9d6de967d5eac6fd79114693cc');
Weather? _weather;

// fetch weather
_fetchWeather() async {
  // get the current city
  String cityName = await _weatherService.getCurrentCity();
  print('City from getCurrentCity(): $cityName');

  // get weather for city
  try {
    final weather = await _weatherService.getWeather(cityName);
    print('Weather data: City: ${weather.cityName}, Temp: ${weather.temperature}, Condition: ${weather.mainCondition}');
    setState(() {
      _weather = weather;
    });
  } 

  // any errors
  catch (e) {
    print(e);
  }
}

//weather animation

//init state
  @override
  void initState() {
    super.initState();
    print('WeatherPage initState called');

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading city.."),

            //animation
            Lottie.asset('assets/cloudy.json'),
        
            //temp
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}