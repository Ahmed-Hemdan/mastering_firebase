import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  File? file;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      file = File(image.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick image"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              getImage();
            },
            child: const Text("Add image from camera"),
          ),
          if(file!=null) Center(
            child: Image.file(
              file! , width: MediaQuery.of(context).size.width *0.75,
            ),
          ),
        ],
      ),
    );
  }
}
