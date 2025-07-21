import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/responsive.dart';

class MainBottonWidget extends StatelessWidget {
  MainBottonWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.background,
    required this.titleColor,
  });
  void Function()? onPressed;
  Color background;
  Color titleColor;
  String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: widthResponsive(context, 16),
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      color: background,
      height: heightResponsive(context, 48),
      minWidth: double.infinity,
      elevation: 0,
    );
  }
}
