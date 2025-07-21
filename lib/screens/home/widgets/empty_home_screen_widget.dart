import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/app_shared_pref.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';
import 'package:tasky_app/screens/home/widgets/custom_app_widget.dart';

class EmptyHomeScreenWidget extends StatelessWidget {
  const EmptyHomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppWidget(),
        SizedBox(height: 85),
        Image.asset(AssetsString.homeScreenImage),
        SizedBox(height: 15),

        Text(
          "What do you want to do today?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff24252C),
          ),
        ),
        SizedBox(height: 10),

        Text(
          "Tap + to add your tasks",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff24252C),
          ),
        ),
      ],
    );
  }
}
