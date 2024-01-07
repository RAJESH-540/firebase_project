import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
   final String title;
  const CustomAlertBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(title),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12),
       ),
       actions: [
         TextButton(onPressed: (){
            Navigator.pop(context);
         }, child: Text('Ok'))
       ],
    );

  }
}
