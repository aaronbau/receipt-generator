import 'package:flutter/material.dart';

class RtTextField extends StatelessWidget {
  RtTextField({
    Key? key,
    this.label = '',
    this.isPassword = false,
    this.isRequired = false,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final bool isPassword;
  final bool isRequired;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      obscureText: isPassword,
      initialValue: '',
      validator: (value) => isRequired && value!.isEmpty ? 'Invalid $label' : null,
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
    );
  }
}
