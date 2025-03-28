import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/constants.dart';
import 'package:minimal_weather_app/model/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<WeatherModel> getweather(cityName) async {
    final response = await http.get(
      Uri.parse("$baseURI?q=$cityName&appid=$apiKey"),
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("fail");
    }
  }
    //get city name
  Future<String> getcity() async {
    //check for permission of the GPS
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //get the permission
      permission = await Geolocator.requestPermission();
    }
    //get position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
    );
    //list of placemarks get the alt. and long. from geo position
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.altitude,
      position.longitude,
    );
    //get name of city by placemark list
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
