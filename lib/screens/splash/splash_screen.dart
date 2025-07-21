import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/app_shared_pref.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tasky_app/screens/home/home_screen.dart';
import 'package:tasky_app/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static final String routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) {
      AppSharedPref.getData("Id").then((value) {
        if (value != null)
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        else
          Navigator.of(
            context,
          ).pushReplacementNamed(OnboardingScreen.routeName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5F33E1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FadeInDown(
              duration: Duration(seconds: 1),
              child: Image.asset(
                AssetsString.taskIcon,
                width: widthResponsive(context, 120),
                height: heightResponsive(context, 50),
                fit: BoxFit.fill,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 500),
              delay: Duration(milliseconds: 300),
              child: Image.asset(
                AssetsString.yIcon,
                width: widthResponsive(context, 24),
                height: heightResponsive(context, 34),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
