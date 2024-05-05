import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/auth/Login/LoginScreen.dart';


import '../components/App_icon.dart';
import '../components/TextFormField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmePasswordController =
      TextEditingController();
  final emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  var auth = FirebaseAuth.instance;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const AppIcon(),
                const Text(
                  "Sigin Up",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Sign Up to continue using the app",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTextField(
                  text: 'Enter your Name',
                  controller: _usernameController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your Name";
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTextField(
                  text: 'Enter your email',
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isNotEmpty && emailReg.hasMatch(value)) {
                      return null;
                    } else {
                      return "Please enter your email";
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTextField(
                  text: "Enter your password",
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your password";
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Confirme Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTextField(
                  text: "Re-enter your password",
                  controller: _confirmePasswordController,
                  validator: (value) {
                    if (value!.isNotEmpty && value == _passwordController.text) {
                    if (value!.isNotEmpty ||
                        value == _passwordController.text) {
                      return null;
                    } else {
                      return "Please enter your password";
                    }
                  }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () async {
                      try {
                        
                        await auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        auth.currentUser!.sendEmailVerification();
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Email verify',
                            desc: 'Please check your email to verify and continue using the app',
                            btnOkOnPress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen() )) ;
                            },
                          ).show();
                        await auth.currentUser!.sendEmailVerification().then(
                              (value) => AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Email verify',
                                btnOkOnPress: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen())),
                                desc:
                                    'Please check your email for email verification and login',
                              ).show(),
                            );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The password provided is too weak.',
                          ).show();
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The account already exists for that email.',
                          ).show();
                        } else {}
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you have an account? ",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
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
