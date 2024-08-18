import 'package:flutter/material.dart';
import 'package:weather_searcher/views/forecast/forecast_view.dart';
import 'package:weather_searcher/views/radar/radar_view.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          RadarView(),
          ForecastView()
        ],
      )
    );
  }
}
