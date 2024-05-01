import 'package:flutter/material.dart';

class LoginIcon extends StatelessWidget {
  final String imagePath;
  const LoginIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Image.asset(imagePath),
    );
  }
}
