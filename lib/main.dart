import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/services/forecast_service.dart';
import 'package:weather_searcher/view_models/forecast_view_model.dart';
import 'package:weather_searcher/view_models/location_service.dart';
import 'package:weather_searcher/views/home/index.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  initializeNotification();
  runApp(const MyApp());
  initializeWorkManager();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

initializeNotification() {
  const AndroidInitializationSettings settings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: settings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformCannnelSpecifics =
      AndroidNotificationDetails('weather_searcher', '雨の予報',
          channelDescription: '傘が必要なことを通知',
          importance: Importance.max,
          priority: Priority.high);
  const NotificationDetails platformCannnelSpecifics =
      NotificationDetails(android: androidPlatformCannnelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformCannnelSpecifics);
}

Future<void> notify() async {
  ForecastService forecastService = ForecastService();
  LocationService locationService = LocationService();

  Location currentLocation = await locationService.getCurrentLocation();
  List<Forecast> forecastList =
      await forecastService.getForecasts(currentLocation);

  Map<String, double> rainVolumeMap = {};
  for (var i = 0; i < forecastList.length; i++) {
    final double rainVolume = forecastList[i].weatherInfo.rain;
    if (rainVolume > 2.0) {
      rainVolumeMap.addAll({'${i * 3}h後': rainVolume});
    }
  }
  if (rainVolumeMap.isNotEmpty) {
    String forecastMessage = '';
    rainVolumeMap.forEach((key, value) {
      forecastMessage += '$keyに${value}mm ';
    });
    await showNotification('雨予報', '$forecastMessage雨が降る予報です。傘を持っていってください。');
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await notify();
    return Future.value(true);
  });
}

void initializeWorkManager() {
  Workmanager().executeTask((task, inputData) async {
    await notify();
    return Future.value(true);
  });

  Workmanager().registerOneOffTask(
    'dailyWeatherCheck',
    'dailyWeatherCheckTask',
    initialDelay: const Duration(seconds: 5),
  );
}
