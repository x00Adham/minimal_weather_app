import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimation extends StatelessWidget {
  final String condition;

  const WeatherAnimation({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    String animationPath;

    switch (condition.toLowerCase()) {
       case 'clouds':
  case 'mist':
  case 'smoke':
  case 'haze':
  case 'dust':
  case 'fog':
     animationPath = 'lib/assets/cloud.json';
  case 'rain':
  case 'drizzle':
  case 'shower rain':
     animationPath = 'lib/assets/rain.json';
  case 'thunderstorm':
    animationPath = 'lib/assets/thunder.json';
  case 'clear':
    animationPath = 'lib/assets/sunny.json';
  default:
    animationPath = 'lib/assets/sunny.json';
    }

    return Lottie.asset(animationPath);
  }
}
