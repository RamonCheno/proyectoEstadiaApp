import 'package:flutter/material.dart';

class CustomTextFormWidget extends StatefulWidget {
  const CustomTextFormWidget(
      {super.key,
      required this.controller,
      required this.hintName,
      required this.icon,
      required this.isObscureText,
      required this.inputType,
      required this.action,
      required this.soloLeer});
  final TextEditingController controller;
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;
  final TextInputAction action;
  final bool soloLeer;

  @override
  State<CustomTextFormWidget> createState() => _CustomTextFormWidgetState();
}

class _CustomTextFormWidgetState extends State<CustomTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
