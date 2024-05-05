import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mastering_firebase/auth/Login/LoginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                if (googleSignIn.isSignedIn() == true) {
                  try {
                    await googleSignIn.disconnect();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  } catch (e) {
                    print(e);
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
                    print(e);
                  }
                }
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
