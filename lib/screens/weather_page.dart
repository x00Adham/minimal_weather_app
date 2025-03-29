import 'package:flutter/material.dart';
import 'package:minimal_weather_app/service/weather_service.dart';
import '../model/weather_model.dart';
import '../widgets/weather_animation.dart';

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
    final cityname = await _weatherService.getCityName();
    try {
      final weather = await _weatherService.fetchWeather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      throw Exception("Error fetching weather data: $e");
    }
  }

  @override
  void initState() {
    fetchweather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 26,
                ),
                Text(
                  _weather?.cityname.toUpperCase() ?? "city...",
                  style: const TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            WeatherAnimation(condition: _weather?.condition ?? "default"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${_weather?.temprature.round() ?? 'temp...'}°",
                  style: const TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _weather?.condition ?? "description...",
                  style: const TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
