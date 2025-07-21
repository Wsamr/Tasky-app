import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({
    super.key,
    required this.task,
    this.isSelected = false,
    this.onTap,
    this.onChanged,
    required this.groupName
  });
  void Function(bool? x)? onChanged;
  TaskModel task;
  bool isSelected;
  bool groupName;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff6E6A7C)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 10,
          children: [
            Radio(
              value: true,
              groupValue: groupName,
              toggleable: true,
              onChanged: onChanged,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff24252C),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${task.date.day}/${task.date.month}/${task.date.year}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff24252C),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
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
                  Text(task.prority.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
