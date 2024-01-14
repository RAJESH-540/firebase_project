import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
   final String hint;
   final IconData? iconData;
   final IconData? sufIcon;
   final VoidCallback? onPressed;
    final TextInputType? keyboradType;
   final TextEditingController controller;
  const CustomTextFields({super.key, required this.hint, required this.controller,  this.iconData, this.keyboradType, this.onPressed, this.sufIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: controller,
      keyboardType: keyboradType,
      decoration: InputDecoration(
        prefixIcon:Icon(iconData, color: Colors.grey,) ,
        suffixIcon: IconButton(onPressed: onPressed, icon: Icon(sufIcon)),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }
}
