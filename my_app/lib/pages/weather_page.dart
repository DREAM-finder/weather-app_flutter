import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/models/weather_model.dart';
import 'package:my_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Fetch the API key from environment variables
  final _weatherService = WeatherService('Weather_API_Key'); // Replace with your actual API key
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city name
    String cityName = await _weatherService.getCurrentCity();
    
    // GET weather for city
    try {
      Weather weather = await _weatherService.fetchWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } 
    // handle error
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {

    if (mainCondition == null) return 'assets/sunny.json'; // default animation

    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'snow':
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sunny.json'; // default animation
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],  // Set background color
      body: Center(  // Wrap Column with Center widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
          children: [
            // city name with larger text
            Text(
              _weather?.cityName ?? 'Loading...',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),  // Add spacing between texts
            

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),


            // temperature with degree symbol
            Text(
              '${_weather?.temperature.round() ?? "Loading..."}°C',
              style: const TextStyle(fontSize: 32),
            ),

            // weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
