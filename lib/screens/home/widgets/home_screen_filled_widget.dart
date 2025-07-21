import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/assets_string.dart';
import 'package:tasky_app/data/firebase/firebase_database.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/detailsScreen/details_screen.dart';
import 'package:tasky_app/screens/home/widgets/custom_app_widget.dart';
import 'package:tasky_app/screens/home/widgets/empty_home_screen_widget.dart';
import 'package:tasky_app/screens/home/widgets/task_widget.dart';
import 'package:tasky_app/widgets/text_form_felid_widget.dart';

class HomeScreenFilledWiidget extends StatefulWidget {
  const HomeScreenFilledWiidget({super.key});
  static String routeName = "HomeScreenFill";

  @override
  State<HomeScreenFilledWiidget> createState() =>
      _HomeScreenFilledWiidgetState();
}

class _HomeScreenFilledWiidgetState extends State<HomeScreenFilledWiidget> {
  // List<DropdownMenuItem> menu = [
  //   DropdownMenuItem(child: Text("After Month")),
  //   DropdownMenuItem(child: Text("tomorrow")),
  // ];
  String? dropdownValue = "Today";
  bool isSelected = false;
  List<TaskModel> tasks = [];

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
                                groupName: isSelected,
                                onChanged: (x) {
                                  isSelected = x ?? false;
                                  tasks[index].isCompeleted = isSelected;
                                  setState(() {});
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
                    ],
                  ),
                ),
      ),
    );
  }

  Future<void> getTasks() async {
    tasks = await FirebaseDatabase.getAllTasks();
    setState(() {});
  }
}

// SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color(0xff6E6A7C)),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   "Completed",
//                   style: TextStyle(color: Color(0xff24252C), fontSize: 12),
//                 ),
//               ),
//               SizedBox(height: 20),
