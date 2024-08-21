import 'package:geolocator/geolocator.dart';
import 'package:weather_searcher/models/location.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('パーミッションエラー');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("位置情報の権限が拒否されました。");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("位置情報の権限が永久に拒否されています。");
    }

    Position position = await Geolocator.getCurrentPosition();
    return Location(latitude: position.latitude, longitude: position.longitude);
  }
}
