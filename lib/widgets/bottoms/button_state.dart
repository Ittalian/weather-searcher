import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/widgets/bottoms/slider/custom_slider.dart';
import 'package:weather_searcher/widgets/forecast/forecast_widget.dart';

class ButtonState extends StatelessWidget {
  final List<Forecast>? forecasts;
  final TextEditingController controller;
  final TextEditingController timeController;
  final Map<String, String> map;
  final Color buttonColor;
  const ButtonState(
      {super.key,
      this.forecasts,
      required this.controller,
      required this.timeController,
      required this.map,
      required this.buttonColor});

  void setTime(dynamic value) {
    timeController.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return forecasts!.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              if (controller.text == 'today')
                Expanded(
                  child: Center(
                      child: ForecastWidget(
                          forecast: forecasts![
                              ((double.parse(timeController.text)) / 3).round() +
                                  3])),
                ),
              if (controller.text == 'tomorrow')
                Expanded(
                  child: Center(
                      child: ForecastWidget(
                          forecast: forecasts![
                              ((double.parse(timeController.text)) / 3)
                                      .round() +
                                  11])),
                ),
              if (controller.text == 'dayAfterTomorrow')
                Expanded(
                  child: Center(
                      child: ForecastWidget(
                          forecast: forecasts![
                              ((double.parse(timeController.text)) / 3)
                                      .round() +
                                  19])),
                ),
              CustomSlider(
                hour: double.parse(timeController.text),
                onChanged: (value) => setTime(value),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map.entries
                    .map((entry) => Expanded(
                        child: InkWell(
                            onTap: () {
                              controller.text = entry.key;
                              timeController.text = '0';
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(), color: buttonColor),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
