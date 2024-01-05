import 'dart:developer';

import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/round_btn.dart';
import '../widgets/textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  signIn(String email , String password)async{
    if(email==""&&password==""){
      return log("enter required fields");
    }
    else{

      try{
        UserCredential? userCredential;
        userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          log("user is created");
           Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        });
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
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
                const Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.deepPurpleAccent),),
                const  SizedBox(height: 30,),
                CustomTextFields(hint: "Email", controller: emailController, iconData: Icons.email),
                const  SizedBox(height: 10,),
                CustomTextFields(hint: "password", controller: passwordController, iconData: Icons.lock),
                const  SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));
                    }, child: const  Text("Don't Have an account? SignUp", style: TextStyle(color: Colors.deepPurpleAccent),), ),
                  ],
                ),
                const  SizedBox(height: 40,),
                CustomElevatedButton(buttonText: 'Sign In', onPressed: () {
                  signIn(emailController.text.toString(), passwordController.text.toString());

                },)
              ],
            ),
          ),
        ),
      );

  }
}
