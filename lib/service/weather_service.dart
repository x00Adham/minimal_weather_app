import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/constants.dart';
import 'package:minimal_weather_app/model/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class ClassName {
  Future<WeatherModel> getweather(cityName) async {
    final response = await http.get(
      Uri.parse("$baseURI?q=$cityName&appid=$apiKey"),
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
      // print(response.body);
    } else {
      throw Exception("fail");
    }
  }

}
