import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Future<List<DocumentSnapshot>> getData() async {
    print("GEtDAta=================================");
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("Users").get();
    return response.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          } else {
            List<DocumentSnapshot> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    DocumentReference docref = FirebaseFirestore.instance
                        .collection("Users")
                        .doc(data[index].id);
                    await FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      DocumentSnapshot snapshot = await transaction.get(docref);
                      if (snapshot.exists) {
                        var snapshotData = snapshot.data();
                        if (snapshotData is Map<String, dynamic>) {
                          print("==========================================");
                          int money = snapshotData["money"] + 100;
                          transaction.update(docref, {"money": money});
                          setState(
                              () {}); // Refresh the UI after the transaction
                          print(
                              "++++++++++++++++++++++++++++++++++++++++++++++");
                        }
                      }
                    });
                  },
                  child: Padding(
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
                              data[index]['name'],
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text(
                              "${data[index]['money']}\$",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 25),
                            ),
                          ],
                        ),
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
