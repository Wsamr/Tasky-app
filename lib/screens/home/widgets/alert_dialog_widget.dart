import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/responsive.dart';
import 'package:tasky_app/screens/auth/widgets/main_button_widget.dart';
import 'package:tasky_app/screens/home/widgets/prority_container_widget.dart';

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({super.key, required this.onTapPro});
  final Function(int) onTapPro;
  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  List<int> priorities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int prority = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Task Priority",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: widthResponsive(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Color(0xff979797), thickness: 1),
          SizedBox(height: heightResponsive(context, 22)),
          Wrap(
            spacing: widthResponsive(context, 16),
            runSpacing: heightResponsive(context, 16),
            children:
                priorities.map((index) {
                  return ProrityContainerWidget(
                    num: index,
                    isSelecyted: prority == index,
                    onTap: () {
                      prority = index;
                      setState(() {});
                    },
                  );
                }).toList(),
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
                onPressed: () {
                  widget.onTapPro(prority);
                  Navigator.of(context).pop();
                },
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
