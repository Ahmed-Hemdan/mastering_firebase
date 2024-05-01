import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/auth/Login/LoginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () async{
          await FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
        }, icon: const Icon(Icons.exit_to_app))
      ],),
    );
  }
}