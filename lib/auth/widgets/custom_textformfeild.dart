import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputAction textinputAction;
  final TextInputType inputType;
  bool? isObscure;
  CustomTextFormFeild({
    required this.labelText,
    required this.controller,
    required this.textinputAction,
    required this.inputType,
    this.isObscure = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'This Feild Is Required';
      //   }
      //   return null;
      // },
      obscureText: isObscure!,
      keyboardType: inputType,
      cursorColor: Theme.of(context).colorScheme.secondary,
      textInputAction: textinputAction,
      controller: controller,
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
