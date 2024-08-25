import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/widgets/bottoms/slider/custom_slider.dart';
import 'package:weather_searcher/widgets/forecast/forecast_widget.dart';
import '../../../utils/constants/forecast/button.dart' as buttons;

class ButtonState extends StatelessWidget {
  final List<Forecast>? forecasts;
  final TextEditingController controller;
  final TextEditingController timeController;
  final Map<String, String> map;
  final Color buttonColor;
  final Color selectedButtonColor;

  const ButtonState({
    super.key,
    this.forecasts,
    required this.controller,
    required this.timeController,
    required this.map,
    required this.buttonColor,
    this.selectedButtonColor = Colors.yellowAccent,
  });

  void setTime(dynamic value) {
    timeController.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return forecasts!.isEmpty
        ? Stack(children: [
            Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map.entries.map((entry) {
                    bool isSelected = controller.text == entry.key;

                    return Expanded(
                        child: InkWell(
                            onTap: () {
                              controller.text = entry.key;
                              timeController.text = '0';
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: isSelected
                                        ? selectedButtonColor
                                        : buttonColor),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ))));
                  }).toList(),
                )),
            const Center(child: CircularProgressIndicator())
          ])
        : Column(
            children: [
              if (controller.text == buttons.buttons['today'])
                Expanded(
                  child: Center(
                      child: ForecastWidget(
                          forecast: forecasts![
                              ((double.parse(timeController.text)) / 3)
                                      .round() +
                                  3])),
                ),
              if (controller.text == buttons.buttons['tomorrow'])
                Expanded(
                  child: Center(
                      child: ForecastWidget(
                          forecast: forecasts![
                              ((double.parse(timeController.text)) / 3)
                                      .round() +
                                  11])),
                ),
              if (controller.text == buttons.buttons['dayAfterTomorrow'])
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map.entries.map((entry) {
                  bool isSelected = controller.text == entry.key;

                  return Expanded(
                      child: InkWell(
                          onTap: () {
                            controller.text = entry.key;
                            timeController.text = '0';
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: isSelected
                                      ? selectedButtonColor
                                      : buttonColor),
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ))));
                }).toList(),
              ),
            ],
          );
  }
}
