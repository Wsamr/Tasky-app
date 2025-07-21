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
  });
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
