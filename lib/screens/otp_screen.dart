import 'package:firebase/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/round_btn.dart';
import '../widgets/textfield.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
   var OtpController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFields(hint: 'Enter phone Number', controller: OtpController, iconData: Icons.phone, keyboradType: TextInputType.number,),
              const SizedBox(height: 20,),
              CustomElevatedButton(buttonText: 'Login', onPressed: ()async{
                 try{
                   PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: OtpController.text.toString());
                   FirebaseAuth.instance.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                 }
                  catch(e){

                  }
              })
            ],
          ),
        ),
      ),
    );
  }
}
