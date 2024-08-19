import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';

class ButtonState extends StatelessWidget {
  final List<Forecast>? forecasts;
  final TextEditingController controller;
  final Map<String, String> map;
  final Color buttonColor;
  const ButtonState(
      {super.key,
      this.forecasts,
      required this.controller,
      required this.map,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return forecasts!.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              if (controller.text == 'today')
                Expanded(
                  child: Center(
                      child: Text(forecasts![0].weather.main,
                          style: const TextStyle(fontSize: 20))),
                ),
              if (controller.text == 'tomorrow')
                Expanded(
                  child: Center(
                      child: Text(forecasts![1].weather.main,
                          style: const TextStyle(fontSize: 20))),
                ),
              if (controller.text == 'dayAfterTomorrow')
                Expanded(
                  child: Center(
                      child: Text(forecasts![2].weather.main,
                          style: const TextStyle(fontSize: 20))),
                ),
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
