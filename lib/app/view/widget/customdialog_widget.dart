import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final Widget messagge;
  final String? title;
  final Icon iconData;
  const CustomDialogWidget(
      {this.title, required this.messagge, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData,
          if (title != null) Text(title!),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
      content: SingleChildScrollView(
        child: Center(
          child: messagge,
        ),
      ),
    );
  }
}
