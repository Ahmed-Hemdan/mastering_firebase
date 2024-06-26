import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/CategoryNotes/CategoryNotes.dart';
import 'package:mastering_firebase/auth/components/TextFormField.dart';

class EditNote extends StatefulWidget {
  final String userId;
  final String categoryId;
  final String docId;
  final String oldNote;

  const EditNote(
      {super.key,
      required this.userId,
      required this.categoryId,
      required this.docId,
      required this.oldNote});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();

  editData() async {
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userId)
          .collection("Categories")
          .doc(widget.categoryId)
          .collection("Notes")
          .doc(widget.docId)
          .update({"note": _noteController.text});
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: "Field to edit note",
      );
    }
  }

  @override
  void initState() {
    _noteController.text = widget.oldNote;
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "We got you back ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 10,
                  controller: _noteController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your note";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Enter your note",
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            editData();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryNotes(
                                  userId: widget.userId,
                                  categoryId: widget.categoryId,
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              title: "Faild",
                              desc: "",
                            ).show();
                          }
                        }
                      },
                      child: const Text("Confirme"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
