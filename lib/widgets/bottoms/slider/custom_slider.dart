import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatelessWidget {
  final double hour;
  final ValueChanged<dynamic> onChanged;

  const CustomSlider({super.key, required this.hour, required this.onChanged});

  String formatLabel(dynamic actualValue) {
    if (actualValue == 0) {
      return 'now';
    }
    return '${(actualValue as double).toInt()}h';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        color: Colors.white,
        child: SfSlider(
          min: 0.0,
          max: 24.0,
          interval: 3.0,
          showLabels: true,
          value: hour,
          onChanged: onChanged,
          stepSize: 3.0,
          labelFormatterCallback: (actualValue, formattedText) => formatLabel(actualValue),
        ));
  }
}
