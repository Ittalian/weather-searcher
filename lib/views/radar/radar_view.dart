import 'package:flutter/material.dart';
import 'package:weather_searcher/widgets/app_bar/custom_app_bar.dart';
import 'package:weather_searcher/widgets/bottoms/button_state.dart';
import '../../utils/constants/radar/radar.dart' as radar;
import '../../utils/constants/radar/places.dart' as radar_map;

class RadarView extends StatelessWidget {
  RadarView({super.key});

  final TextEditingController placeController =
      TextEditingController(text: 'here');

  String getImage(String place) {
    return radar_map.imagePlaces[place]!;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: placeController,
      builder:(context, value, child) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getImage(placeController.text)),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: const CustomAppBar(title: radar.appBarTitle, barColor: Colors.blue),
          backgroundColor: Colors.white.withOpacity(0),
          body: ButtonState(controller: placeController, map: radar_map.textPlaces, buttonColor: Colors.blue[200]!),
        )));
  }
}
