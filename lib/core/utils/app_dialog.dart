import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/responsive.dart';

abstract class AppDialog {
  static showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: widthResponsive(context, 16)),
              Text(
                "Loading",
                style: TextStyle(fontSize: widthResponsive(context, 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  static showDialogError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error title", style: TextStyle(color: Colors.red)),
          content: Text(
            error,
            style: TextStyle(fontSize: widthResponsive(context, 16)),
          ),
        );
      },
    );
  }
}
