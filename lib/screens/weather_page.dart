import 'package:flutter/material.dart';
import 'package:minimal_weather_app/service/weather_service.dart';

import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  // Instance of WeatherService to fetch weather data
  final _weatherService = WeatherService();

  // Variable to store the fetched weather data
  WeatherModel? _weather;
  //class to fetch the data from api
  fetchweather() async {
    // get the city name from method
    final cityname = await _weatherService.getcity();
    try {
      final weather = await _weatherService.getweather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("error:$e");
    }
  }

  @override
  void initState() {
    fetchweather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}
