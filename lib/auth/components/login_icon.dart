import 'package:flutter/material.dart';

class LoginIcon extends StatelessWidget {
  final String imagePath;
  final void Function() ontap; 
  const LoginIcon({super.key, required this.imagePath , required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Image.asset(imagePath),
      ),
    );
  }
}
