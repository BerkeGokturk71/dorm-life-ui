import 'package:flutter/material.dart';

class TextFieldArea extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;
  const TextFieldArea(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
