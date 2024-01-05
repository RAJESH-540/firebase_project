import 'package:firebase/screens/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  const Text("Firebase"),
        centerTitle: true,
         actions: [
           IconButton(onPressed: (){
             FirebaseAuth.instance.signOut().then((value) {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignIn()));
             });
           }, icon: Icon(Icons.logout))
         ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
