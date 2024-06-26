import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/CategoryNotes/CategoryNotes.dart';
import 'package:mastering_firebase/HomeScreen/HomeScreen.dart';
import 'package:mastering_firebase/HomeScreen/HomeComponents/components.dart';
import 'package:mastering_firebase/auth/Login/LoginScreen.dart';
import 'package:mastering_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          iconTheme: const IconThemeData(
            color: Colors.amber,
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.amber,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.amber, shape: OvalBorder()),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
 //FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),