class WeatherModel {
  final String cityname;
  final String condition;
  final double temprature;

  WeatherModel({
    required this.cityname,
    required this.condition,
    required this.temprature,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityname: json["name"],
      condition: json["weather"][0]["main"],
      temprature: json["main"]["temp"] -273, // Convert from Kelvin to Celsius
    );
  }
}
