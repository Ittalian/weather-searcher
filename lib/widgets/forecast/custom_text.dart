import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String weatherName;
  final String text;
  final double? fontSize;
  final FontWeight? weight;
  const CustomText(
      {super.key,
      required this.weatherName,
      required this.text,
      this.fontSize,
      this.weight});

  Color? getColor() {
    switch (weatherName) {
      case 'Clear':
        return Colors.yellow;
      case 'Sunny':
        return Colors.red[200];
      case 'Rain':
        return Colors.blue[500];
      case 'Clouds':
        return const Color.fromARGB(255, 0, 133, 77);
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: fontSize, fontWeight: weight, color: getColor()));
  }
}
