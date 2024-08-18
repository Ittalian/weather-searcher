import 'package:flutter/material.dart';

class ButtonState extends StatelessWidget {
  final TextEditingController controller;
  final Map<String, String> map;
  final Color buttonColor;
  const ButtonState(
      {super.key,
      required this.controller,
      required this.map,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Center(
          child: Text(controller.text)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map.entries
              .map((entry) => Expanded(
                  child: InkWell(
                      onTap: () {
                        controller.text = entry.key;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(), color: buttonColor),
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )))))
              .toList(),
        ),
      ],
    );
  }
}
