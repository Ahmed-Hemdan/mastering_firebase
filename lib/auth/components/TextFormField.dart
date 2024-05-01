import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const DefaultTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.validator,
    required,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
