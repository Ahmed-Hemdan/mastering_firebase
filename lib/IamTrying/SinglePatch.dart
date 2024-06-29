import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SinglePatchScreen extends StatefulWidget {
  const SinglePatchScreen({super.key});

  @override
  State<SinglePatchScreen> createState() => _SinglePatchScreenState();
}

class _SinglePatchScreenState extends State<SinglePatchScreen> {
  CollectionReference collref = FirebaseFirestore.instance.collection("Users");
  Future getData() async {
    var response = await FirebaseFirestore.instance.collection("Users").get();
    return response.docs;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single Patch"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          WriteBatch batch = FirebaseFirestore.instance.batch();
          DocumentReference doc1 =
              FirebaseFirestore.instance.collection("Users").doc("1");
          DocumentReference doc2 =
              FirebaseFirestore.instance.collection("Users").doc("2");
          DocumentReference doc3 =
              FirebaseFirestore.instance.collection("Users").doc("3");
          try {
            batch.delete(doc1);
            batch.set(doc3, {
              'name': "omran",
              "age": 36,
              "money": 500,
            });
            batch.set(doc2, {
              'name': "omar",
              "age": 32,
              "money": 5000,
            });
            batch.commit();
            setState(() {});
          } catch (e) {
            print("there is error while batch ");
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("There is error while getting data "),
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text("There is no data to see"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 226, 226),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            snapshot.data[index]['name'],
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            "${snapshot.data[index]['money']}\$",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
