import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? file;
  String? url;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        file = File(image.path);
        String imageName = basename(image.path);
        var storageRef = FirebaseStorage.instance.ref(imageName);
        await storageRef.putFile(file!);
          url = await storageRef.getDownloadURL();
      }

      setState(() {});
    } catch (e) {
      print("error ========================= $e");
    }
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
          if (file != null)
            Center(
              child: Image.network(
                url!,
                width: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
        ],
      ),
    );
  }
}
