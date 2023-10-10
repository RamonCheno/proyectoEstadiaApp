import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String messagge;
  final Icon iconData;
  const CustomDialogWidget(
      {required this.messagge, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Center(
        child: Column(
          children: [
            iconData,
            Text(messagge),
          ],
        ),
      ),
    );
  }
}
