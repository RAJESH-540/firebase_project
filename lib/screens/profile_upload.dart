
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/widgets/round_btn.dart';
import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpload extends StatefulWidget {
  const ProfileUpload({super.key});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  var nameController= TextEditingController();
   File? pickedImage;
   _showAlert(){
     return showDialog(context: context, builder: ( BuildContext context){
       return AlertDialog(
             title: const Text("Pick Image From"),
             actions: [
               TextButton(onPressed: (){
                 Navigator.pop(context);
               }, child: const Text("ok"))
             ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: (){
                    pickImage(ImageSource.gallery);
                     Navigator.pop(context);
                  },
                  title: const Text("Gallery"),
                    trailing: Icon(Icons.image),
                ),
                ListTile(
                  onTap: (){
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  title: const Text("Camera"),
                    trailing: Icon(Icons.camera),
                ),
              ],
            ),
       );
     });
   }
    auth(String title)async{
     if(title==''&& pickedImage==null){
       return log("Enter required fields");
     }
      else{
          uploadImage();
     }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  _showAlert();
                },
                child:pickedImage==null?CircleAvatar(
                  radius: 70,
                  child: Icon(Icons.person, size: 60,),
                ): CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(pickedImage!,),)
              ),
               const  SizedBox(height: 10,),
              CustomTextFields(hint: "name", controller: nameController, iconData: Icons.add),
              SizedBox(height: 20,),
              CustomElevatedButton(buttonText: "save", onPressed: (){
                auth(nameController.text.toString());
              })
            ],
          ),
        ),
      ),
    );
  }
  pickImage( ImageSource imageSource) async{
      try{
        final photo=  await ImagePicker().pickImage(source: imageSource);
        if(photo==null) return;
         final tempPage= File(photo.path);
        setState(() {
          pickedImage=tempPage;

        });

      }
      catch(ex){
        print(ex.toString());

      }

  }
  uploadImage()async{
     UploadTask uploadTask=  FirebaseStorage.instance
         .ref("Profile Picture")
         .child(nameController.text.toString()).putFile(pickedImage!);
     TaskSnapshot taskSnapshot =await uploadTask;
     String imgurl= await taskSnapshot.ref.getDownloadURL();
     String imagename= nameController.text.toString();
     FirebaseFirestore.instance.collection("Image").doc(imagename).set({
       "Image Url":imgurl,
       "Image name":imagename,
     });
  }
}
