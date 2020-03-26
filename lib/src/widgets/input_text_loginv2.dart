import 'package:flutter/material.dart';

class InputTextLoginv2 extends StatefulWidget {
  
  final String label;
  final Function(String) validator;
  final bool isSecure;
  final TextInputType inputType;

  InputTextLoginv2({Key key,@required this.label, this.validator, this.isSecure = false, this.inputType = TextInputType.text}) : super(key: key);

  @override
  _InputTextLoginv2State createState() => _InputTextLoginv2State();
}

class _InputTextLoginv2State extends State<InputTextLoginv2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.isSecure,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding: EdgeInsets.symmetric(vertical: 10)
      ),
    );
  }
}