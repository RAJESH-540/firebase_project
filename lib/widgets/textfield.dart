import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
   final String hint;
   final IconData iconData;
    final TextInputType? keyboradType;
   final TextEditingController controller;
  const CustomTextFields({super.key, required this.hint, required this.controller, required this.iconData, this.keyboradType});

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: controller,
      keyboardType: keyboradType,
      decoration: InputDecoration(

        prefixIcon:Icon(iconData, color: Colors.grey,) ,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }
}
