import 'package:flutter/material.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/widgets/radar/radar_widget.dart';
import '../../utils/constants/radar/places.dart' as radar_map;

class RadarButtonState extends StatelessWidget {
  final Location? currentLocation;
  final TextEditingController controller;
  final Map<String, String> map;
  final Color buttonColor;
  final Color selectedButtonColor;

  const RadarButtonState({
    super.key,
    required this.currentLocation,
    required this.controller,
    required this.map,
    required this.buttonColor,
    this.selectedButtonColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return currentLocation == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map.entries.map((entry) {
              bool isSelected = controller.text == entry.key;

              return Expanded(
                  child: InkWell(
                      onTap: () {
                        controller.text = entry.key;
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
                            style: TextStyle(
                              fontSize: 20,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ))));
            }).toList(),
          )
        : Column(
            children: [
              if (controller.text == 'here' && currentLocation != null)
                Expanded(
                    child: Center(
                        child: RadarWidget(
                            url:
                                'https://openweathermap.org/weathermap?basemap=map&cities=false&layer=radar&lat=${currentLocation!.latitude}&lon=${currentLocation!.longitude}&zoom=10'))),
              if (controller.text == 'myHouse' &&
                  radar_map.urlPlaces['myHouse'] != null)
                Expanded(
                    child: Center(
                        child:
                            RadarWidget(url: radar_map.urlPlaces['myHouse']!))),
              if (controller.text == 'moeHouse' &&
                  radar_map.urlPlaces['moeHouse'] != null)
                Expanded(
                    child: Center(
                        child: RadarWidget(
                            url: radar_map.urlPlaces['moeHouse']!))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map.entries.map((entry) {
                  bool isSelected = controller.text == entry.key;

                  return Expanded(
                      child: InkWell(
                          onTap: () {
                            controller.text = entry.key;
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
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ))));
                }).toList(),
              ),
            ],
          );
  }
}
