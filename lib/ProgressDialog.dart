import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({this.message});
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        children: [
          CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }
}
