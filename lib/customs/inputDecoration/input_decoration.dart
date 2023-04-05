import 'package:flutter/material.dart';

OutlineInputBorder border({Color color = Colors.blue}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(width: 2, color: color),
  );
}

InputDecoration inputDecoration(
    {String? hintText,
    Icon? prefixIcon,
    Widget? suffixIcon,
    bool isRequired = false}) {
  return InputDecoration(
      border: border(),
      // disabledBorder: border(color: Colors.grey),
      errorBorder: border(color: Colors.red),
      enabledBorder: border(),
      focusedBorder: border(color: Colors.blue.shade700),
      focusedErrorBorder: border(color: Colors.red),
      isDense: true,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: "$hintText",
      constraints: const BoxConstraints.tightFor(width: 500),
      hintText: hintText);
}
