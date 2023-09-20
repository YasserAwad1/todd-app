import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/widgets/custom_textformfeild.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class UpdateReportScreen extends StatefulWidget {
  static const routeName = 'update-report-screen';
  KidModel? kid;
  ReportModel? previousReport;

  UpdateReportScreen({
    this.kid,
    this.previousReport,
  });

  @override
  State<UpdateReportScreen> createState() => _UpdateReportScreenState();
}

class _UpdateReportScreenState extends State<UpdateReportScreen> {
  TextEditingController reportController = TextEditingController();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  bool success = false;
  String? report;
  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });
        // ignore: use_build_context_synchronously
        success = await Provider.of<ReportProvider>(context, listen: false)
            .updateReport(widget.kid!.id!, widget.previousReport!.id!,
                reportController.text);

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

    reportController.value =
        TextEditingValue(text: widget.previousReport!.description);
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
                text: AppLocalizations.of(context)!.send,
                icon: const Icon(Icons.send, color: Colors.white),
                color: Theme.of(context).colorScheme.secondary,
              ),
              ButtonState.loading: IconedButton(
                  text: AppLocalizations.of(context)!.loading,
                  color: Theme.of(context).colorScheme.secondary),
              ButtonState.fail: IconedButton(
                  text: AppLocalizations.of(context)!.failed,
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  color: const Color.fromARGB(255, 207, 66, 66)),
              ButtonState.success: IconedButton(
                  text: AppLocalizations.of(context)!.success,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0.sp),
            child: Column(children: [
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormFeild(
                labelText: AppLocalizations.of(context)!.monthlyReport,
                controller: reportController,
                textinputAction: TextInputAction.next,
                inputType: TextInputType.multiline,
                maxlines: 25,
                alignLabelWithHint: true,
                onChanged: (val) {},
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
