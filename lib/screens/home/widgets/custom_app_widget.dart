import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/app_shared_pref.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';

class CustomAppWidget extends StatelessWidget {
  const CustomAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AssetsString.logoIconBlack, height: 28, width: 78),
        Row(
          children: [
            ImageIcon(
              AssetImage(AssetsString.logOutIcon),
              size: 24,
              color: Color(0xffFF4949),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                AppSharedPref.removeData("Id");
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Text(
                "Log out",
                style: TextStyle(
                  color: Color(0xffFF4949),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
