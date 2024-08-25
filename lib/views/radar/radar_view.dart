import 'package:flutter/material.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/view_models/location_service.dart';
import 'package:weather_searcher/widgets/app_bar/custom_app_bar.dart';
import 'package:weather_searcher/widgets/bottoms/button/radar_button_state.dart';
import '../../utils/constants/radar/radar.dart' as radar;
import '../../utils/constants/radar/places.dart' as radar_map;

class RadarView extends StatelessWidget {
  RadarView({super.key});

  final TextEditingController placeController =
      TextEditingController(text: 'here');
  final LocationService locationService = LocationService();

  String getImage(String place) {
    return radar_map.imagePlaces[place]!;
  }

  Future<Location?> getCurrentLocation() async {
    try {
      return await locationService.getCurrentLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: placeController,
      builder: (context, value, child) {
        return FutureBuilder<Location?>(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            Widget radarContent = const Center(child: Text('データがありません'));

            if (snapshot.connectionState == ConnectionState.waiting) {
              radarContent = Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: RadarButtonState(
                    currentLocation: null,
                    controller: placeController,
                    map: radar_map.textPlaces,
                    buttonColor: Colors.blue[200]!,
                  )),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              radarContent = const Center(child: Text('エラーが発生しました'));
            } else if (snapshot.hasData && snapshot.data != null) {
              Location currentLocation = snapshot.data!;

              radarContent = RadarButtonState(
                currentLocation: currentLocation,
                controller: placeController,
                map: radar_map.textPlaces,
                buttonColor: Colors.blue[200]!,
              );
            }

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(getImage(placeController.text)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: const CustomAppBar(
                  title: radar.appBarTitle,
                  barColor: Colors.blue,
                ),
                backgroundColor: Colors.white.withOpacity(0),
                body: radarContent,
              ),
            );
          },
        );
      },
    );
  }
}
