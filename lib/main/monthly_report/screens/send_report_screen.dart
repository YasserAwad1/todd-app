import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/progress_button.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class SendReportScreen extends StatefulWidget {
  static const routeName = 'send-report-screen';
  KidModel? kid;
  ReportModel? previousReport;
  bool? isEditing = false;

  SendReportScreen({
    this.kid,
    this.previousReport,
    this.isEditing,
  });

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  TextEditingController descriptionController = TextEditingController();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  bool success = false;
  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });
        if (widget.isEditing!) {
          success = await Provider.of<ReportProvider>(context, listen: false)
              .updateReport(widget.kid!.id!, widget.previousReport!.id!,
                  descriptionController.text);
        } else {
          // ignore: use_build_context_synchronously
          success = await Provider.of<ReportProvider>(context, listen: false)
              .sendReport(widget.kid!.id!, descriptionController.text);
        }

        setState(() {
          stateTextWithIcon = success ? ButtonState.success : ButtonState.fail;
          if (stateTextWithIcon == ButtonState.success) {
            Future.delayed(const Duration(milliseconds: 800))
                .then((value) async {
              await Provider.of<ReportProvider>(context, listen: false)
                  .getChildReport(widget.kid!.id!);
              // ignore: use_build_context_synchronously
              Navigator.pop(
                context,
                MyNavigator(
                  curves: Curves.easeIn,
                  screen: MonthlyReportScreen(kid: widget.kid),
                ),
              );
            });
          }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditing!) {
      descriptionController.value =
          TextEditingValue(text: widget.previousReport!.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: widget.kid!.name,
          titleContainerWidth: 180.w,
          withBackButton: true,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: ProgressButton.icon(
            iconedButtons: {
              ButtonState.idle: IconedButton(
                text: 'Send',
                icon: const Icon(Icons.send, color: Colors.white),
                color: Theme.of(context).colorScheme.secondary,
              ),
              ButtonState.loading: IconedButton(
                  text: 'Loading',
                  color: Theme.of(context).colorScheme.secondary),
              ButtonState.fail: const IconedButton(
                  text: 'Failed',
                  icon: Icon(Icons.cancel, color: Colors.white),
                  color: Color.fromARGB(255, 207, 66, 66)),
              ButtonState.success: IconedButton(
                  text: 'Success',
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  color: Colors.green.shade400)
            },
            onPressed: onPressedIconWithText,
            state: stateTextWithIcon,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0.sp),
          child: Column(children: [
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              maxLines: 10,
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Report',
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
