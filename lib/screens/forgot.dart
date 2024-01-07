import 'dart:math';

import 'package:firebase/screens/signIn.dart';
import 'package:firebase/widgets/round_btn.dart';
import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/alertbox.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    var controller = TextEditingController();
      forgot(String email ){
       if(email==""){
         return showDialog(context: context, builder: (BuildContext buildContext){
           return const  CustomAlertBox(title: "Enter Required Fields");
         });
       }
        else{
            FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
              return showDialog(context: context, builder: (BuildContext buildContext){
                return const  CustomAlertBox(title: "We have Sent  an Mail  to Reset Password");
              });
            }).then((value) => { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignIn()))});
       }

      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         leading: IconButton(onPressed: (){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignIn()));
         }, icon:  const Icon(Icons.arrow_back, color: Colors.white,),),
         backgroundColor: Colors.deepPurpleAccent,
       ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text("Forgot Password", style: TextStyle(fontSize: 25.0, color: Colors.deepPurpleAccent),),
                    const SizedBox(height: 30,),
                    CustomTextFields(hint: "Enter email ", controller: controller, iconData: Icons.email),
                    const SizedBox(height: 30,),
                    CustomElevatedButton(buttonText: "Send", onPressed: (){
                       forgot(controller.text.toString());
                    })
                  ],
                ),
              ),
            ),
    );
  }
}
