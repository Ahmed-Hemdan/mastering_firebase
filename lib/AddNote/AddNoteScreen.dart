import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
    final String userId;
  final String categoryId;
  const AddNoteScreen({super.key, required this.userId, required this.categoryId});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
     var storage = FirebaseFirestore.instance;
       final TextEditingController _noteController = TextEditingController();

    addNote() async {
    try {
      if (_formkey.currentState!.validate()) {
        await storage
            .collection("Users")
            .doc(widget.userId)
            .collection('Categories')
            .doc(
              widget.categoryId,
            )
            .collection("Notes")
            .add({"note": _noteController.text});
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Somthing happend while adding note',
      ).show();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_photo_alternate,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("Add"),
      ),
    );
  }
}
