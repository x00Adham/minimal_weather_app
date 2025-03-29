import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/constants.dart';
import 'package:minimal_weather_app/model/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      final uri = Uri.parse("$baseURI?q=$cityName&appid=$apiKey");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to fetch weather data. Status code: ${response.statusCode},$cityName");
      }
    } catch (e) {
      throw Exception("Error fetching weather data: $e");
    }
  }

  Future<String> getCityName() async {
    try {
      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );

      // Get placemarks from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Extract city name
      String? city = placemarks.isNotEmpty ? placemarks[0].administrativeArea : null;
      if (city == null || city.isEmpty) {
        throw Exception("City name not found");
      }

      return city;
    } catch (e) {
      throw Exception("Error retrieving city name: $e");
    }
  }
}
