import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';

class CustomProgressButton extends StatefulWidget {
  int childId;
  String description;
  VoidCallback function;
  CustomProgressButton({
    required this.childId,
    required this.description,
    required this.function,
  });
  @override
  _CustomProgressButtonState createState() => _CustomProgressButtonState();
}

class _CustomProgressButtonState extends State<CustomProgressButton> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ProgressButton.icon(iconedButtons: {
        ButtonState.idle: IconedButton(
          text: 'Send',
          icon: const Icon(Icons.send, color: Colors.white),
          color: Theme.of(context).colorScheme.secondary,
        ),
        ButtonState.loading: IconedButton(
            text: 'Loading', color: Theme.of(context).colorScheme.secondary),
        ButtonState.fail: IconedButton(
            text: 'Failed',
            icon: const Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            text: 'Success',
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      }, onPressed: widget.function, state: stateTextWithIcon),
    );
  }

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });
        bool success = await Provider.of<ReportProvider>(context, listen: false)
            .sendReport(widget.childId, widget.description.toString());

        setState(() {
          stateTextWithIcon = success ? ButtonState.success : ButtonState.fail;
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(
      () {
        stateTextWithIcon = stateTextWithIcon;
      },
    );
  }
}
