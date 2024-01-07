import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/signIn.dart';
import 'package:firebase/widgets/round_btn.dart';
import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/alertbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   var titleController= TextEditingController();
   var desController= TextEditingController();
    addData(String title, String desc)async{
       if(title==""&& desc ==""){
         return showDialog(context: context, builder: (BuildContext buildContext){
           return const  CustomAlertBox(title: "Enter Required Fields");
         });
       }
        else{
           FirebaseFirestore.instance.collection("Notes").doc(title).set({
            "Title":title,
            "Desc":desc,
          });
       }
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title:  const Text("Firebase"),
        centerTitle: true,
         actions: [
           IconButton(onPressed: (){
             FirebaseAuth.instance.signOut().then((value) {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignIn()));
             });
           }, icon:  const Icon(Icons.logout, color: Colors.white,))
         ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Column(
            children: [
                const SizedBox(height: 40,),
                CustomTextFields(hint: 'Title', controller: titleController, iconData: Icons.title),
                const SizedBox(height: 20,),
                CustomTextFields(hint: 'desc', controller: desController, iconData: Icons.description),
               const SizedBox(height: 20,),
               CustomElevatedButton(buttonText: 'add Data', onPressed: (){
                  addData(titleController.text.toString(), desController.text.toString());
               })

            ],
          ),
        ),
      ),
    );
  }
}
