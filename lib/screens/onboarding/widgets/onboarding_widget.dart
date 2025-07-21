import 'package:flutter/material.dart';
import 'package:tasky_app/models/onboarding_model.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.pages,
    required this.currentPage,
    required this.widthScreen,
  });

  final List<OnboardingModel> pages;
  final int currentPage;
  final double widthScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pages[currentPage].imagePathl),
        SizedBox(height: widthScreen * .1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 25,
              height: 4,
              color: currentPage == index ? Color(0xff5F33E1) : Colors.grey,
            ),
          ),
        ),

        SizedBox(height: widthScreen * .1),
        Text(
          pages[currentPage].mainText,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: widthScreen * .1),

        Column(
          children: [
            Text(
              pages[currentPage].text1,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              pages[currentPage].text2,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
