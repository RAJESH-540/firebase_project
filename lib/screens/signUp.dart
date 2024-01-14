import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/alertbox.dart';
import '../widgets/round_btn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      return showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return const CustomAlertBox(title: "Enter Required Fields");
          });
    } else {
      try {
        UserCredential? userCredential;
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          print("user is created");
        }).then((value) {
          FirebaseFirestore.instance.collection("User").doc(email).set({
            "Email": email,
            "password":password,
          }).then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          });
        });
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.deepPurpleAccent),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                  hint: "Email",
                  controller: emailController,
                  iconData: Icons.email),
              const SizedBox(
                height: 10,
              ),
              CustomTextFields(
                  hint: "password",
                  controller: passwordController,
                  iconData: Icons.lock),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already  Have an account? SignUp",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              CustomElevatedButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  signUp(emailController.text.toString(),
                      passwordController.text.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
