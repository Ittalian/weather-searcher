import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/widgets/forecast/forecast_widget.dart';
import 'package:weather_searcher/widgets/radar/radar_widget.dart';
import '../../utils/constants/radar/places.dart' as radar_map;

class ButtonState extends StatelessWidget {
  final List<Forecast>? forecasts;
  final Location? currentLocation;
  final TextEditingController controller;
  final Map<String, String> map;
  final Color buttonColor;
  const ButtonState(
      {super.key,
      this.forecasts,
      this.currentLocation,
      required this.controller,
      required this.map,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.text == 'today')
          Expanded(
            child: Center(child: ForecastWidget(forecast: forecasts![3])),
          ),
        if (controller.text == 'tomorrow')
          Expanded(
            child: Center(child: ForecastWidget(forecast: forecasts![11])),
          ),
        if (controller.text == 'dayAfterTomorrow')
          Expanded(
            child: Center(child: ForecastWidget(forecast: forecasts![19])),
          ),
        if (controller.text == 'here')
          Expanded(
              child: Center(
                  child: RadarWidget(
                      url:
                          'https://openweathermap.org/weathermap?basemap=map&cities=false&layer=radar&lat${currentLocation!.latitude}&lon=${currentLocation!.longitude}&zoom=10'))),
        if (controller.text == 'myHouse')
          Expanded(
              child: Center(
                  child: RadarWidget(url: radar_map.urlPlaces['myHouse']!))),
        if (controller.text == 'moeHouse')
          Expanded(
              child: Center(
                  child: RadarWidget(url: radar_map.urlPlaces['moeHouse']!))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map.entries
              .map((entry) => Expanded(
                  child: InkWell(
                      onTap: () {
                        controller.text = entry.key;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(), color: buttonColor),
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )))))
              .toList(),
        ),
      ],
    );
  }
}
