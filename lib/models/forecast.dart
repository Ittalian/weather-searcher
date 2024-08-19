import 'package:weather_searcher/models/weather.dart';
import 'package:weather_searcher/models/weather_info.dart';
import 'package:weather_searcher/models/winds.dart';

class Forecast {
  final WeatherInfo weatherInfo;
  final Weather weather;
  final Winds winds;

  Forecast({required this.weatherInfo, required this.weather, required this.winds});
}
