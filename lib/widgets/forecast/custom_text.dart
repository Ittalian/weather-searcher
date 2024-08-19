import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? weight;
  const CustomText(
      {super.key, required this.text, this.color, this.fontSize, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: fontSize, fontWeight: weight, color: color));
  }
}
