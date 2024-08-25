import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_searcher/view_models/forecast_view_model.dart';
import 'package:weather_searcher/widgets/app_bar/custom_app_bar.dart';
import 'package:weather_searcher/widgets/bottoms/button/button_state.dart';
import '../../utils/constants/forecast/forecast.dart' as forecast;
import '../../utils/constants/forecast/dates.dart' as forecast_map;

class ForecastView extends StatelessWidget {
  ForecastView({super.key});

  final TextEditingController dateController =
      TextEditingController(text: 'today');
  final TextEditingController timeController = TextEditingController(text: '0');

  String getImage(String date) {
    return forecast_map.imagesDates[date]!;
  }

  @override
  Widget build(BuildContext context) {
    final forecastViewModel = context.watch<ForecastViewModel>();

    return ValueListenableBuilder(
        valueListenable: dateController,
        builder: (context, value, child) => ValueListenableBuilder(
            valueListenable: timeController,
            builder: (context, value, child) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(getImage(dateController.text)),
                        fit: BoxFit.cover)),
                child: Scaffold(
                  appBar: const CustomAppBar(
                      title: forecast.appBarTitle, barColor: Colors.yellow),
                  backgroundColor: Colors.white.withOpacity(0),
                  body: ButtonState(
                      forecasts: forecastViewModel.forecasts,
                      controller: dateController,
                      timeController: timeController,
                      map: forecast_map.textDates,
                      buttonColor: Colors.yellow[200]!),
                ))));
  }
}
