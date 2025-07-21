import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/responsive.dart';

class BottonTextAuth extends StatelessWidget {
  BottonTextAuth({
    super.key,
    required this.hyperText,
    required this.mainText,
    this.onTap,
  });
  String mainText;
  String hyperText;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Don’t have an account? Register
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: mainText),
                TextSpan(
                  text: hyperText,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: widthResponsive(context, 12),
                    color: Color(0xff5F33E1),
                  ),
                ),
              ],
              style: TextStyle(
                color: Color(0xff6E6A7C),
                fontSize: widthResponsive(context, 12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
