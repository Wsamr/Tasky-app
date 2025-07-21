import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/data/firebase/firebase_database.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';
import 'package:tasky_app/screens/detailsScreen/widgets/calendar_dialog_widget.dart';
import 'package:tasky_app/screens/detailsScreen/widgets/edit_filelds_aler.dart';
import 'package:tasky_app/screens/home/home_screen.dart';
import 'package:tasky_app/screens/home/widgets/alert_dialog_widget.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key});
  static final String routeName = "DetailsScreen";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController taskName = TextEditingController();

  final TextEditingController description = TextEditingController();
  String taskPro = "Default";
  String taskTime = "Today";

  bool isCompeleted = false;
  DateTime? selectedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Image.asset(AssetsString.closeIcon),
          onTap: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthResponsive(context, 20),
          vertical: heightResponsive(context, 44),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: isCompeleted,
                  toggleable: true,
                  onChanged: (bool? value) {
                    isCompeleted = value ?? false;
                    setState(() {});
                    task.isCompeleted = isCompeleted;
                    print(task.isCompeleted);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskTitle,
                      style: TextStyle(
                        fontSize: widthResponsive(context, 20),
                        color: Color(0xff24252C),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      task.description,
                      style: TextStyle(
                        color: Color(0xff6E6A7C),
                        fontSize: widthResponsive(context, 16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  child: Image.asset(AssetsString.editIcon),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditFileldsAlerWidget(
                          taskName: taskName,
                          description: description,
                          onPressedSave: () async {
                            task.taskTitle = taskName.text;
                            task.description = description.text;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: heightResponsive(context, 44)),
            Row(
              children: [
                Image.asset(AssetsString.timerIcon),
                SizedBox(width: widthResponsive(context, 5)),
                Text(
                  "Task Time :",
                  style: TextStyle(
                    color: Color(0xff24252C),
                    fontSize: widthResponsive(context, 16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CalendarDialogWidget(
                          onSelectedDate: (p0) {
                            print(p0.day);
                            task.date = p0;
                            taskTime =
                                "${task.date.day}/${task.date.month}/${task.date.year}";
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthResponsive(context, 16),
                      vertical: heightResponsive(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffE0DFE3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "$taskTime" ?? "today",
                      style: TextStyle(
                        fontSize: widthResponsive(context, 12),
                        fontWeight: FontWeight.w400,
                        color: Color(0xff24252C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightResponsive(context, 30)),

            Row(
              children: [
                Image.asset(AssetsString.flagIcon),
                SizedBox(width: widthResponsive(context, 5)),
                Text(
                  "Task Priority :",
                  style: TextStyle(
                    color: Color(0xff24252C),
                    fontSize: widthResponsive(context, 16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogWidget(
                          onTapPro: (p0) {
                            task.prority = p0;
                            taskPro = p0.toString();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthResponsive(context, 16),
                      vertical: heightResponsive(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffE0DFE3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      taskPro,
                      style: TextStyle(
                        fontSize: widthResponsive(context, 12),
                        fontWeight: FontWeight.w400,
                        color: Color(0xff24252C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightResponsive(context, 38)),
            GestureDetector(
              onTap: () {
                AppDialog.showDialogLoading(context);
                FirebaseDatabase.deletTask(task)
                    .then((_) {
                      Navigator.of(context).pop();
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(HomeScreen.routeName);
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showDialogError(context, error.toString());
                    });
              },
              child: Row(
                children: [
                  Image.asset(AssetsString.deleteIcon),
                  SizedBox(width: widthResponsive(context, 3)),
                  Text(
                    "Delete Task",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: widthResponsive(context, 16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            MainBottonWidget(
              title: "Edit Task",
              background: Color(0xff5F33E1),
              titleColor: Colors.white,
              onPressed: () async {
                await FirebaseDatabase.updateTask(task).then((_) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
