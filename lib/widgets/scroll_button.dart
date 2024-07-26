import 'package:flutter/material.dart';

class ScrollButton extends StatelessWidget {
  final IconData icon;
  final ScrollController controller;
  final double offset;

  const ScrollButton({
    super.key,
    required this.icon,
    required this.controller,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        controller.animateTo(
          controller.offset + offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }
}
