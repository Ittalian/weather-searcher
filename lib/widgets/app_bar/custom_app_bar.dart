import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color barColor;
  const CustomAppBar({super.key, required this.title, required this.barColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: barColor.withOpacity(0.7),
      title: Text(title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
