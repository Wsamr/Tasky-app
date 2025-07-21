// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';

class CalendarDialogWidget extends StatefulWidget {
  const CalendarDialogWidget({Key? key, required this.onSelectedDate})
    : super(key: key);
  final Function(DateTime) onSelectedDate;

  @override
  State<CalendarDialogWidget> createState() => _CalendarDialogWidgetState();
}

class _CalendarDialogWidgetState extends State<CalendarDialogWidget> {
  late DateTime focusedDay = DateTime.now();
  late DateTime selectedDay = DateTime.now();
  String getMonthName(DateTime date) {
    return monthNames[date.month - 1];
  }

  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(children: [Text(getMonthName(focusedDay)), Divider()]),
      content: SizedBox(
        width: double.maxFinite,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDay,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),

              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xff5F33E1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                ),
                defaultTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black,
                ),
                defaultDecoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                outsideDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                ),
                weekendDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                ),
                weekendTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black),
                weekendStyle: TextStyle(color: Colors.red),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) {
                if (selectedDay == null) return false;
                return isSameDay(selectedDay, day);
              },
              onPageChanged: (newFocusedDay) {
                setState(() {
                  focusedDay = newFocusedDay;
                });
              },
              headerVisible: false,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = selectedDay;
                });
              },
            ),
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
                    onPressed: () {
                      widget.onSelectedDate(selectedDay);
                      Navigator.of(context).pop();
                    },
                    background: Color(0xff5F33E1),
                    titleColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
