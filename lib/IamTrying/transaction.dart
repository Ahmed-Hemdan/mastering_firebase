import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('Users').snapshots();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      body: StreamBuilder<QuerySnapshot>(stream: userStream, builder: (context , snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator.adaptive(),);
        }else if (snapshot.hasError){
          return const Center(child: Text("There is error while getting data"),);
        }else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              return InkWell(
                  onTap: () async {
                    DocumentReference docref = FirebaseFirestore.instance
                        .collection("Users")
                        .doc(snapshot.data!.docs[index].id);
                    await FirebaseFirestore.instance.runTransaction(
                      (transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(docref);
                        if (snapshot.exists) {
                          var snapshotData = snapshot.data();
                          if (snapshotData is Map<String, dynamic>) {
                            int money = snapshotData["money"] + 100;
                            transaction.update(docref, {"money": money});
                            setState(() {});
                          }
                        }
                      },
                    );
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
                              snapshot.data!.docs[index]['name'],
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text(
                              "${snapshot.data!.docs[index]['money']}\$",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            }, );
        }
      },) , 
    );
  }
}



