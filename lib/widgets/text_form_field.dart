import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.controller,
      this.validation,
      this.label,
      this.isObscure});

  final TextEditingController controller;
  final String? Function(String? value)? validation;
  final Widget? label;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
          label: label,
          border: const OutlineInputBorder(borderSide: BorderSide())),
    );
  }
}
