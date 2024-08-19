import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_searcher/services/forecast_service.dart';
import 'package:weather_searcher/view_models/forecast_view_model.dart';
import 'package:weather_searcher/views/home/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ForecastViewModel(ForecastService()))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Index(),
        ));
  }
}
