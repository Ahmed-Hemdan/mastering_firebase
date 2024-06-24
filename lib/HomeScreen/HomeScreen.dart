import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mastering_firebase/HomeScreen/HomeComponents/components.dart';
import 'package:mastering_firebase/auth/Login/LoginScreen.dart';
import 'package:mastering_firebase/auth/components/TextFormField.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _catigoryName = TextEditingController();
  var storage = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List data = [];
  bool isLoading = true;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  addCategory() async {
    try {
      if (_formkey.currentState!.validate()) {
        await storage
            .collection("Users")
            .doc(userId)
            .collection('Categories')
            .add({
          "Category_name": _catigoryName.text,
        });
        Navigator.pop(context);
        getData();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Somthing happend while add category',
      ).show();
    }
  }

  getData() async {
    try {
      data = [];
      QuerySnapshot response = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("Categories")
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _catigoryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              if (await googleSignIn.isSignedIn()) {
                try {
                  await googleSignIn.disconnect();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } catch (e) {
                  throw ('Error while logout from google !!!!!');
                }
              } else {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } catch (e) {
                  throw ('Error while logout');
                }
              }
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Add category',
            btnOk: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                addCategory();
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
              child: DefaultTextField(
                controller: _catigoryName,
                hintText: 'Category name',
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "name can't be empty";
                  }
                },
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
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 160,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => InkWell(
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Delete Category',
                      desc: 'Are you sure you wanna delete this category ??',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userId)
                            .collection("Categories")
                            .doc(data[index].id)
                            .delete();
                        getData();
                      },
                    ).show();
                  },
                  child:
                      HomeComponents(folderName: data[index]["Category_name"])),
            ),
    );
  }
}
