import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final error;
  const ErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.not_interested_outlined,
            size: 30.0, color: Colors.white),
        const SizedBox(height: 16.0),
        Text(
          error,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
