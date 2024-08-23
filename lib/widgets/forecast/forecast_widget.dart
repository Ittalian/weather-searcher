import 'package:flutter/material.dart';
import 'package:weather_searcher/models/forecast.dart';
import 'package:weather_searcher/widgets/forecast/custom_text.dart';

class ForecastWidget extends StatelessWidget {
  final Forecast forecast;
  const ForecastWidget({super.key, required this.forecast});

  String getWeatherImage(String weatherName) {
    switch (weatherName) {
      case 'Sunny':
        return 'images/sunny.gif';
      case 'Clouds':
        return 'images/cloudy.gif';
      case 'Rain':
        return 'images/rainy.gif';
      case 'Clear':
        return 'images/clear.gif';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.fromLTRB(40, 99, 40, 50),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getWeatherImage(forecast.weather.main)),
                fit: BoxFit.cover)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          CustomText(
            weatherName: forecast.weather.main,
            text: forecast.weather.main,
            fontSize: 40,
            weight: FontWeight.w900,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          CustomText(
            weatherName: forecast.weather.main,
            text: forecast.weather.description,
            fontSize: 25,
            weight: FontWeight.w800,
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  weatherName: forecast.weather.main,
                  text: '最高${forecast.weatherInfo.tempMax}℃',
                  fontSize: 20,
                  weight: FontWeight.bold),
              const Padding(padding: EdgeInsets.only(left: 20)),
              CustomText(
                weatherName: forecast.weather.main,
                text: '最低${forecast.weatherInfo.tempMin}℃',
                fontSize: 20,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                weatherName: forecast.weather.main,
                text: '気圧${forecast.weatherInfo.pressure}Pa',
                fontSize: 20,
                weight: FontWeight.bold,
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              CustomText(
                weatherName: forecast.weather.main,
                text: '湿度${forecast.weatherInfo.humidity}%',
                fontSize: 20,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                weatherName: forecast.weather.main,
                text: '風速${forecast.winds.speed}m/s',
                fontSize: 20,
                weight: FontWeight.bold,
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              CustomText(
                weatherName: forecast.weather.main,
                text: '最大${forecast.winds.gust}m/s',
                fontSize: 20,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
        ]),
      ),
    ]);
  }
}
