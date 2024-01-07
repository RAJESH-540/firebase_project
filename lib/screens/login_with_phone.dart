import 'package:firebase/screens/otp_screen.dart';
import 'package:firebase/widgets/round_btn.dart';
import 'package:firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
   var phoneController=  TextEditingController();
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
               CustomTextFields(hint: 'Enter phone Number', controller: phoneController, iconData: Icons.phone


                 ,),
               const SizedBox(height: 20,),
                CustomElevatedButton(buttonText: 'Login', onPressed: ()async{
                   await FirebaseAuth.instance.verifyPhoneNumber(
                       phoneNumber: phoneController.text.toString(),
                       verificationCompleted: (PhoneAuthCredential credential){},
                       verificationFailed: ( FirebaseAuthException ex ){},
                       codeSent: (String verificationId, int? resendToken){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>OtpScreen(verificationId: verificationId,)));
                       },
                       codeAutoRetrievalTimeout: (String verificationId){});
                })
             ],
           ),
         ),
       ),
    );
  }
}
