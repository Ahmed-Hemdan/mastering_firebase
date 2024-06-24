import 'package:flutter/material.dart';

class HomeComponents extends StatelessWidget {
  final String folderName;
  const HomeComponents({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/folder-icon.png',
              height: 100,
            ),
            Text(folderName)
          ],
        ),
      ),
    );
  }
}
