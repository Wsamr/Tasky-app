import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/data/firebase/firebase_database.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/detailsScreen/details_screen.dart';
import 'package:tasky_app/core/common/calendar_dialog_widget.dart';
import 'package:tasky_app/core/common/priorities_alert_dialog_widget.dart';
import 'package:tasky_app/screens/home/widgets/custom_app_widget.dart';
import 'package:tasky_app/screens/home/widgets/home_screen_filled_widget.dart';
import 'package:tasky_app/screens/home/widgets/empty_home_screen_widget.dart';
import 'package:tasky_app/screens/home/widgets/prority_container_widget.dart';
import 'package:tasky_app/screens/home/widgets/show_botton_sheet_widget.dart';
import 'package:tasky_app/screens/home/widgets/task_widget.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var addTask = TextEditingController();

  var description = TextEditingController();
  bool istimeSave = false;
  bool isSel = false;

  int priority = 0;
  String? dropdownValue = "Today";
  bool isSelected = false;
  List<TaskModel> tasks = [];
  List<TaskModel> compeleteTasks = [];

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            tasks.isEmpty
                ? EmptyHomeScreenWidget()
                : Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppWidget(),
                      SizedBox(height: 16),

                      TextFormFelidWidget(
                        hintText: "Search for your task...",
                        prefixIcon: Image.asset(AssetsString.searchIcon),
                      ),
                      SizedBox(height: 45),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xff6E6A7C)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xff6E6A7C)),
                            ),
                          ),
                          value: dropdownValue,
                          style: TextStyle(
                            color: Color(0xff24252C),
                            fontSize: 15,
                          ),
                          items:
                              ["Today", "Tomorrow"].map((String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 25,

                          iconEnabledColor: Color(0xff5F33E1),
                          iconDisabledColor: Color(0xff5F33E1),
                        ),
                      ),
                      SizedBox(height: 18),

                      Expanded(
                        child: ListView.builder(
                          itemBuilder:
                              (context, index) => TaskWidget(
                                groupName: tasks[index].isCompeleted,
                                onChanged: (x) async {
                                  tasks[index].isCompeleted = x ?? false;
                                  if (tasks[index].isCompeleted == true)
                                    compeleteTasks.add(tasks[index]);
                                  await FirebaseDatabase.addCompeletedTask(
                                    taskTitle: tasks[index].taskTitle,
                                    date: tasks[index].date,
                                    prority: tasks[index].prority,
                                    description: tasks[index].description,
                                  );
                                  await FirebaseDatabase.deletTask(
                                    tasks[index],
                                  );
                                  tasks.removeAt(index);

                                  setState(() {});

                                  print(isSelected);
                                },
                                task: tasks[index],
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    DetailsScreen.routeName,
                                    arguments: tasks[index],
                                  );
                                },
                              ),
                          itemCount: tasks.length,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text("Compeleted"),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemBuilder:
                      //         (context, index) => TaskWidget(
                      //           groupName: compeleteTasks[index].isCompeleted,
                      //           onChanged: (x) async {
                      //             print(isSelected);
                      //           },
                      //           task: compeleteTasks[index],
                      //           onTap: () {
                      //             Navigator.of(context).pushNamed(
                      //               DetailsScreen.routeName,
                      //               arguments: tasks[index],
                      //             );
                      //           },
                      //         ),
                      //     itemCount: tasks.length,
                      //   ),
                      // ),
                    ],
                  ),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ShowBottonSheetWidget(
                taskTitle: addTask,
                description: description,
                istimeSave: istimeSave,
                priority: priority.toString(),
                flagOntap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PrioritiesAlertDialogWidget(
                        onTapPro: (p0) {
                          priority = p0;
                          setState(() {});
                          print(addTask.text);
                          print(description.text);
                          print(priority.toString());
                        },
                      );
                    },
                  );
                },
                timerOntap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CalendarDialogWidget(
                        onSelectedDate: (p0) {
                          dateTime = p0;
                          istimeSave = true;
                          setState(() {});
                        },
                      );
                    },
                  );
                },
                sendOntap: () async {
                  AppDialog.showDialogLoading(context);
                  await FirebaseDatabase.addTask(
                        taskTitle: addTask.text,
                        date: dateTime,
                        prority: priority,
                        description: description.text,
                      )
                      .then((_) async {
                        Navigator.of(context).pop();
                        addTask.clear();
                        description.clear();
                        priority = 1;
                        dateTime = DateTime.now();

                        Navigator.of(
                          context,
                        ).pushReplacementNamed(HomeScreen.routeName);
                      })
                      .catchError((error) {
                        Navigator.of(context).pop();

                        AppDialog.showDialogError(context, error.toString());
                      });
                },
              );
            },
          );
        },
        child: Icon(Icons.add, color: Color(0xff5F33E1), size: 30),
        shape: CircleBorder(),
        backgroundColor: Color(0xff24252C),
      ),
    );
  }

  Future<void> getTasks() async {
    tasks = await FirebaseDatabase.getAllTasks();
    setState(() {});
  }
}
