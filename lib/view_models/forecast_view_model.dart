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
    forecasts = await forecastService.getForecasts(location);
    notifyListeners();
  }
}
