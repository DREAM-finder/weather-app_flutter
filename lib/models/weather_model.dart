
// Weather Model
// This file contains the Weather model class, which represents the weather data structure.
// It includes properties for city name, temperature, and weather condition. The fromJson method is used to create a Weather object from a JSON response.
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      // Convert temperature from Kelvin to Celsius
      mainCondition: json['weather'][0]['main'],
    );
  }
}
