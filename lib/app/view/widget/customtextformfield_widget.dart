import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormWidget extends StatefulWidget {
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;
  final TextInputAction action;
  final bool soloLeer;
  final TextEditingController controller;
  final int? lengthChar;
  final bool isEnable;

  const CustomTextFormWidget(
      {super.key,
      required this.controller,
      required this.hintName,
      required this.icon,
      required this.action,
      this.lengthChar,
      this.inputType = TextInputType.text,
      this.isObscureText = false,
      this.soloLeer = false,
      this.isEnable = true});

  @override
  State<CustomTextFormWidget> createState() => _CustomTextFormWidgetState();
}

class _CustomTextFormWidgetState extends State<CustomTextFormWidget> {
  // String? _activeField = '';
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      child: TextFormField(
        enabled: widget.isEnable,
        style: TextStyle(
            color: widget.isEnable ? Colors.black : const Color(0xff757575),
            fontSize: 12.sp),
        buildCounter: (BuildContext context,
            {required int currentLength,
            required bool isFocused,
            int? maxLength}) {
          if (maxLength != null) {
            if (widget.soloLeer == false) {
              return isFocused
                  ? Text(
                      '$currentLength/$maxLength',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                      semanticsLabel: 'Input constraints',
                    )
                  : null;
            }
          }
          return null;
        },
        controller: widget.controller,
        readOnly: widget.soloLeer,
        textInputAction: widget.action,
        focusNode: widget.soloLeer == false ? _focusNode : null,
        obscureText: widget.isObscureText,
        keyboardType: widget.inputType,
        maxLength: widget.lengthChar,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese ${widget.hintName}';
          }
          return null;
        },
        decoration: InputDecoration(
          enabled: widget.isEnable,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)).w,
            borderSide: BorderSide(
              color: _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)).w,
            borderSide: const BorderSide(
              color: Color(0xffF69100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)).w,
            borderSide: const BorderSide(
              color: Color(0Xff4caf50),
            ),
          ),
          prefixIcon: Icon(widget.icon,
              color: _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100)),
          // hintStyle: const TextStyle(color: Color(0xff757575)),
          labelText: widget.hintName,
          labelStyle:
              TextStyle(fontSize: 12.sp, color: const Color(0xff757575)),
          floatingLabelStyle:
              TextStyle(color: const Color(0xff4caf50), fontSize: 12.sp),
          fillColor: Colors.white,
          filled: true,
        ),
        onTap: () {
          _focusNode.requestFocus();
          // setState(() {
          //   // _activeField = widget.hintName;
          // });
        },
        onFieldSubmitted: (value) {
          _focusNode.nextFocus();
          setState(() {
            // _activeField = widget.hintName;
            _isFocused = false;
          });
        },
        onEditingComplete: () {
          _focusNode.requestFocus(_focusNode);
          setState(() {
            _isFocused = false;
          });
        },
        onTapOutside: (value) {
          _focusNode.unfocus();
          setState(() {
            _isFocused = false;
            // _activeField = null;
          });
        },
      ),
    );
  }
}
