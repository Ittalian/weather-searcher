import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_searcher/views/forecast/forecast_view.dart';
import 'package:weather_searcher/views/home/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    // MultiProvider(
        // providers: [],
        // child:
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Index(),
        );
        // );
  }
}
