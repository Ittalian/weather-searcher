import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/models/location.dart';
import 'package:weather_searcher/services/forecast_service.dart';
import 'package:weather_searcher/view_models/forecast_view_model.dart';
import 'package:weather_searcher/view_models/location_service.dart';
import 'package:weather_searcher/views/home/index.dart';
import 'package:workmanager/workmanager.dart';

void main() {
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
  String url =
      'https://api.openweathermap.org/data/2.5/forecast?lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&units=metric&appid=b4970909603bfd0c159084a6beed02f2&cnt=28';
  List<Forecast> forecastList =
      await forecastService.getForecasts(currentLocation, url);

  for (var forecast in forecastList) {
    final double rainVolume = forecast.weatherInfo.rain;
    if (rainVolume > 2.0) {
      await showNotification(
          '雨予報', '今日は3時間で${rainVolume}mmの雨が降る予報です。傘を持っていってください。');
      break;
    }
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

  Workmanager().registerPeriodicTask(
    'dailyWeatherCheck',
    'dailyWeatherCheckTask',
    frequency: const Duration(hours: 24),
    initialDelay: calculateInitialDelay(),
    constraints: Constraints(networkType: NetworkType.connected),
  );
}

Duration calculateInitialDelay() {
  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day, 0, 0, 10);
  return nextMidnight.difference(now);
}
