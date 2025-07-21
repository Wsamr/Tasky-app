import 'package:flutter/material.dart';

class TextFormFelidWidget extends StatelessWidget {
  TextFormFelidWidget({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
  });
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff6E6A7C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff5F33E1)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xff6E6A7C),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
