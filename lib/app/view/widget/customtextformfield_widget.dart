import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormWidget extends StatefulWidget {
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;
  final TextInputAction action;
  final bool soloLeer;
  final TextEditingController controller;
  final int? lengthChar;

  const CustomTextFormWidget(
      {super.key,
      required this.controller,
      required this.hintName,
      required this.icon,
      required this.action,
      this.lengthChar,
      this.inputType = TextInputType.text,
      this.isObscureText = false,
      this.soloLeer = false});

  @override
  State<CustomTextFormWidget> createState() => _CustomTextFormWidgetState();
}

class _CustomTextFormWidgetState extends State<CustomTextFormWidget> {
  String? _activeField = '';
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
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: TextFormField(
        buildCounter: (BuildContext context,
            {required int currentLength,
            required bool isFocused,
            int? maxLength}) {
          if (maxLength != null) {
            return isFocused
                ? Text(
                    '$currentLength/$maxLength',
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                    semanticsLabel: 'Input constraints',
                  )
                : null;
          }
          return null;
        },
        controller: widget.controller,
        readOnly: widget.soloLeer,
        textInputAction: widget.action,
        focusNode: _focusNode,
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
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: Color(0Xff4caf50),
            ),
          ),
          prefixIcon: Icon(widget.icon,
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : Colors.grey),
          hintStyle: const TextStyle(color: Color(0xff757575)),
          labelText: widget.hintName,
          floatingLabelStyle: const TextStyle(
            color: Color(0xff4caf50),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        onTap: () {
          _focusNode.requestFocus();
          setState(() {
            _activeField = widget.hintName;
          });
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).nextFocus();
          setState(() {
            _activeField = widget.hintName;
            _isFocused = false;
          });
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_focusNode);
          setState(() {
            _isFocused = false;
          });
        },
        onTapOutside: (value) {
          FocusScope.of(context).unfocus();
          setState(() {
            _isFocused = false;
            _activeField = null;
          });
        },
      ),
    );
  }
}
