import 'package:flutter/foundation.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/services/forecast_service.dart';
import 'package:weather_searcher/view_models/location_service.dart';

class ForecastViewModel extends ChangeNotifier {
  final ForecastService forecastService;

  List<Forecast> forecasts = [];
  LocationService locationService = LocationService();

  ForecastViewModel(this.forecastService) {
    fetchForecasts();
  }

  void fetchForecasts() async {
    Location location = await locationService.getCurrentLocation();
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=b4970909603bfd0c159084a6beed02f2&cnt=20';
    forecasts = await forecastService.getForecasts(location, url);
    notifyListeners();
  }
}
