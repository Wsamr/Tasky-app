import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class ShowBottonSheetWidget extends StatelessWidget {
  const ShowBottonSheetWidget({
    super.key,
    required this.description,
    required this.taskTitle,
    this.flagOntap,
    this.sendOntap,
    this.timerOntap,
    this.istimeSave = false,
    this.priority = "1",
  });
  final istimeSave;
  final String priority;
  final void Function()? timerOntap;
  final void Function()? flagOntap;
  final void Function()? sendOntap;
  final TextEditingController taskTitle;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Text(
            "Add Task",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          TextFormFelidWidget(
            hintText: "Enter your task",
            controller: taskTitle,
          ),
          SizedBox(height: 25),
          Text(
            "Description",
            style: TextStyle(
              color: Color(0xff6E6A7C),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15),
          TextFormFelidWidget(
            hintText: "Enter your Description",
            controller: description,
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthResponsive(context, 16),
                  vertical: heightResponsive(context, 8),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffE0DFE3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "today",
                  style: TextStyle(
                    fontSize: widthResponsive(context, 12),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff24252C),
                  ),
                ),
              ),

              SizedBox(width: widthResponsive(context, 10)),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff6E6A7C)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Image.asset(AssetsString.flagIcon),
                    Text("$priority" ?? "1"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: heightResponsive(context, 20)),
          Row(
            children: [
              GestureDetector(
                onTap: timerOntap,
                child: ImageIcon(
                  AssetImage(AssetsString.timerIcon),
                  size: 24,
                  color: Color(0xff5F33E1),
                ),
              ),
              SizedBox(width: 10),

              GestureDetector(
                onTap: flagOntap,
                child: ImageIcon(
                  AssetImage(AssetsString.flagIcon),
                  size: 24,
                  color: Color(0xff5F33E1),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: sendOntap,
                child: ImageIcon(
                  AssetImage(AssetsString.sendIcon),
                  size: 24,
                  color: Color(0xff5F33E1),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
