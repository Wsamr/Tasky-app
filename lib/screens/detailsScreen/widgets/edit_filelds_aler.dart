import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class EditFileldsAlerWidget extends StatelessWidget {
  const EditFileldsAlerWidget({
    super.key,
    required this.description,
    required this.taskName,
    this.onPressedSave,
  });
  final TextEditingController taskName;
  final TextEditingController description;
  final Function()? onPressedSave;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "New Task Name",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormFelidWidget(hintText: "Edit task Name", controller: taskName),
          SizedBox(height: heightResponsive(context, 10)),
          Text(
            "New Task Description ",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormFelidWidget(
            hintText: "Edit description",
            controller: description,
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: MainBottonWidget(
                title: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop();
                },
                background: Color(0xffECE6F0),
                titleColor: Color(0xff5F33E1),
              ),
            ),
            SizedBox(width: widthResponsive(context, 16)),
            Expanded(
              child: MainBottonWidget(
                title: "Save",
                onPressed: onPressedSave,
                background: Color(0xff5F33E1),
                titleColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
