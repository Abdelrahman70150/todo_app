import 'package:flutter/material.dart';
 typedef MyValidator = String? Function(String?);
class MyTextFormField extends StatelessWidget {

String? hintText ;
MyValidator? validate ;
String lableText ;
IconButton? suffixIcon;
bool isPassword ;
TextInputType inputType;
TextEditingController controller;
 MyTextFormField({
   required this.controller,
   this.inputType=TextInputType.text,
   this.hintText,this.isPassword=false, this.validate, required this.lableText, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(

        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: lableText,
       labelStyle: TextStyle(
            color: const Color(0xffa9a9a9).withOpacity(.4),
            fontSize: 16,
            fontWeight: FontWeight.bold),

      ),
      validator: validate,
    );
  }
}
