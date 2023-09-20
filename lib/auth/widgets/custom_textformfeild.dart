import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputAction textinputAction;
  final TextInputType inputType;
  final Function(String) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxlines;
  final TextDirection? direction;
  final bool? alignLabelWithHint;
  bool? isObscure;

  CustomTextFormFeild(
      {required this.labelText,
      this.controller,
      required this.textinputAction,
      required this.inputType,
      required this.onChanged,
      this.maxlines = 1,
      this.alignLabelWithHint = false,
      this.direction,
      this.prefixIcon,
      this.suffixIcon,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isObscure!,
      keyboardType: inputType,
      maxLines: maxlines,
      cursorColor: Theme.of(context).colorScheme.secondary,
      textInputAction: textinputAction,
      controller: controller ?? controller,
      textDirection: direction ?? direction,
      decoration: InputDecoration(
        alignLabelWithHint: alignLabelWithHint,
        prefixIcon: prefixIcon ?? prefixIcon,
        suffixIcon: suffixIcon ?? suffixIcon,
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
