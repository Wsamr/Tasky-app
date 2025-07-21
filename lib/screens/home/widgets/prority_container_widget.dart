import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/responsive.dart';

class ProrityContainerWidget extends StatelessWidget {
  const ProrityContainerWidget({
    super.key,
    this.num = 1,
    this.onTap,
    this.isSelecyted = false,
  });
  final int num;
  final void Function()? onTap;
  final bool isSelecyted;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widthResponsive(context, 15),
          vertical: heightResponsive(context, 5),
        ),

        decoration: BoxDecoration(
          border: Border.all(
            color: isSelecyted ? Colors.transparent : Color(0xff6E6A7C),
            width: 1.2,
          ),
          color: isSelecyted ? Color(0xff5F33E1) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsString.flagIcon,
              width: 24,
              height: 24,
              color: isSelecyted ? Colors.white : Color(0xff5F33E1),
            ),
            SizedBox(height: heightResponsive(context, 5)),
            Text(
              num.toString(),
              style: TextStyle(
                fontSize: widthResponsive(context, 16),
                fontWeight: FontWeight.w400,
                color: isSelecyted ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
