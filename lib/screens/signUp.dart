import 'dart:math';

import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/round_btn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
     signUp(String email , String password)async{
      if(email==""&&password==""){
        return log("enter required fields" as num);
      }
      else{

        try{
          UserCredential? userCredential;
          userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
            log("user is created" as num);
          });
        }
         on FirebaseAuthException catch(ex){
          log(ex.code.toString() as num);
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
              const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.deepPurpleAccent),),
              const  SizedBox(height: 20,),
              CustomTextFields(hint: "Email", controller: emailController, iconData: Icons.email),
              const  SizedBox(height: 10,),
              CustomTextFields(hint: "password", controller: passwordController, iconData: Icons.lock),
              const  SizedBox(height: 10,),
                Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   TextButton(onPressed: () {
                      Navigator.pop(context);
                   }, child: const  Text("Already  Have an account? SignUp", style: TextStyle(color: Colors.deepPurpleAccent),), ),
                 ],
               ),
              const  SizedBox(height: 40,),
              CustomElevatedButton(buttonText: 'Sign Up', onPressed: () {
                    signUp(emailController.text.toString(), passwordController.text.toString());

              },)
            ],
          ),
        ),
      ),
    );
  }
}
