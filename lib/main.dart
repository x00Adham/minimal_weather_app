import 'package:flutter/material.dart';
import 'screens/weather_page.dart';
void main() {
  runApp(const Weatherapp());
}

class Weatherapp extends StatelessWidget {
  const Weatherapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WeatherPage(),);
  }
}
