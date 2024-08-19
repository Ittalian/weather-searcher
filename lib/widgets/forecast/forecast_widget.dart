import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/widgets/forecast/custom_text.dart';

class ForecastWidget extends StatelessWidget {
  final Forecast forecast;
  const ForecastWidget({super.key, required this.forecast});

  String getWeatherImage(String weatherName) {
    switch (weatherName) {
      case 'Sunny':
        return 'images/sunny.png';
      case 'Clouds':
        return 'images/cloudy.png';
      case 'Rain':
        return 'images/rainy.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 150, 50, 50),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getWeatherImage(forecast.weather.main)),
              fit: BoxFit.cover)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        CustomText(text: forecast.weather.main, fontSize: 40),
        const Padding(padding: EdgeInsets.only(top: 10)),
        CustomText(text: forecast.weather.description, fontSize: 25),
        const Padding(padding: EdgeInsets.only(top: 40)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: '最高${forecast.weatherInfo.tempMax}℃', fontSize: 20),
            const Padding(padding: EdgeInsets.only(left: 20)),
            CustomText(
                text: '最低${forecast.weatherInfo.tempMin}℃', fontSize: 20),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: '気圧${forecast.weatherInfo.pressure}Pa', fontSize: 20),
            const Padding(padding: EdgeInsets.only(left: 20)),
            CustomText(
                text: '湿度${forecast.weatherInfo.humidity}%', fontSize: 20),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: '風速${forecast.winds.speed}m/s', fontSize: 20),
            const Padding(padding: EdgeInsets.only(left: 20)),
            CustomText(text: '最大${forecast.winds.gust}m/s', fontSize: 20),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
      ]),
    );
  }
}
