import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_searcher/models/weather.dart';
import 'dart:convert';

import 'package:weather_searcher/models/weather_info.dart';
import 'package:weather_searcher/models/winds.dart';

class ForecastService {
  Future<List<Forecast>> getForecasts(Location location, String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherList = data['list'];
        List<Forecast> forecast = _getForecast(weatherList);
        return forecast;
      } else {
        throw Exception('天気を取得できませんでした');
      }
    } catch (e) {
      print(e);
      throw Exception('天気を取得できませんでした');
    }
  }

  List<Forecast> _getForecast(List<dynamic> weatherList) {
    List<Forecast> targetForecastList = [];
    for (var weather in weatherList) {
      final weatherInfoJson = weather['main'];
      final weatherJson = weather['weather'][0];
      final windsJson = weather['wind'];
      WeatherInfo weatherInfo = WeatherInfo(
          tempMin: (weatherInfoJson['temp_min'] as num).toDouble(),
          tempMax: (weatherInfoJson['temp_max'] as num).toDouble(),
          pressure: weatherInfoJson['pressure'],
          humidity: weatherInfoJson['humidity']);
      Weather targetWeather = Weather(
          main: weatherJson['main'], description: weatherJson['description']);
      Winds winds = Winds(
          speed: (windsJson['speed'] as num).toDouble(),
          gust: (windsJson['gust'] as num).toDouble());
      Forecast targetForecast = Forecast(
          weatherInfo: weatherInfo, weather: targetWeather, winds: winds);
      targetForecastList.add(targetForecast);
    }
    return targetForecastList;
  }
}
