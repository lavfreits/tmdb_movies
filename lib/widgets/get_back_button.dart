import 'package:flutter/material.dart';

class GetBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GetBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          Text(
            ' Voltar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
