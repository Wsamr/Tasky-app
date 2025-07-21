import 'package:flutter/material.dart';

double widthResponsive(
  BuildContext context,
  double figmaWidth, {
  double baseWidth = 375,
}) {
  return MediaQuery.of(context).size.width * (figmaWidth / baseWidth);
}

double heightResponsive(
  BuildContext context,
  double figmaHeight, {
  double baseHeight = 812,
}) {
  return MediaQuery.of(context).size.height * (figmaHeight / baseHeight);
}
