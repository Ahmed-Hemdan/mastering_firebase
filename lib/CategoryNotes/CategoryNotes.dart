import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mastering_firebase/EditNote/EditNote.dart';

class CategoryNotes extends StatefulWidget {
  final String userId;
  final String categoryId;
  const CategoryNotes(
      {super.key, required this.userId, required this.categoryId});

  @override
  State<CategoryNotes> createState() => _CategoryNotesState();
}

class _CategoryNotesState extends State<CategoryNotes> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();
  var storage = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> data = [];
  String catName = '';
  bool isLoading = true;
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
        getData();
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

  getData() async {
    try {
      DocumentSnapshot title = await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userId)
          .collection("Categories")
          .doc(widget.categoryId)
          .get();
      catName = title['Category_name'];
      data = [];
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userId)
          .collection("Categories")
          .doc(widget.categoryId)
          .collection("Notes")
          .get();

      data.addAll(response.docs);
      isLoading = false;
      setState(() {});
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'somthing happend while loading !',
        btnOkOnPress: () {},
      ).show();
      print("==================$e===============================");
    }
  }

  deleteData(int index) async {
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.userId)
          .collection("Categories")
          .doc(widget.categoryId)
          .collection('Notes')
          .doc(data[index].id)
          .delete();
      getData();
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: "Field to Delete note",
      );
    }
  }

  @override
  void initState() {
    getData();
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
        title: Text(catName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Add note',
            btnOk: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                addNote();
                Navigator.pop(context);
                _noteController.clear();
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            btnCancel: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                _noteController.clear();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            body: Form(
              key: _formkey,
              child: TextFormField(
                maxLines: 10,
                controller: _noteController,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "note can't be empty";
                  }
                },
                decoration: InputDecoration(
                  hintText: "Add your note",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ).show();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) => data.isEmpty
                  ? const Center(
                      child: Text(
                        'there is no notes here yet',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        // Specify a key if the Slidable is dismissible.
                        key: const ValueKey(0),

                        // The end action pane is the one at the right or the bottom side.
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 1,
                              onPressed: (context) {
                                deleteData(index);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      userId: widget.userId,
                                      categoryId: widget.categoryId,
                                      docId: data[index].id,
                                      oldNote: data[index]['note'],
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 215, 215),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data[index]["note"],
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
