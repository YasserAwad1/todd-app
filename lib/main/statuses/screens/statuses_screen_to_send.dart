import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/kids/dates/providers/dates_provider.dart';
import 'package:toddily_preschool/main/kids/dates/screens/dates_screen.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/main/statuses/statusesToSend/widgets/status_widget_to_send.dart';
import 'package:toddily_preschool/models/status/status_model.dart';

class StatusesScreenToSend extends StatefulWidget {
  static const routeName = '/statuses-screen-to-send';
  int? childId;
  // String? date;

  StatusesScreenToSend({
    this.childId,
    // this.date,
  });

  @override
  State<StatusesScreenToSend> createState() => _StatusesScreenToSendState();
}

class _StatusesScreenToSendState extends State<StatusesScreenToSend> {
  bool startAnimation = false;
  var _statusesToSendFuture;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  bool success = false;

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });
        // Provider.of<StatusProvider>(context, listen: false).statusesToSendList;
        success = await Provider.of<StatusProvider>(context, listen: false)
            .sendStatus(widget.childId!);

        setState(() {
          stateTextWithIcon = success ? ButtonState.success : ButtonState.fail;
          if (stateTextWithIcon == ButtonState.success) {
            Future.delayed(const Duration(milliseconds: 800))
                .then((value) async {
              await Provider.of<DatesProvider>(context, listen: false)
                  .getDatesByChildId(widget.childId!);
              Provider.of<StatusProvider>(context, listen: false)
                  .substatusListFromScreen
                  .clear();
              Navigator.pop(
                context,
                MyNavigator(
                  curves: Curves.easeIn,
                  screen: DatesScreen(),
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
    Provider.of<StatusProvider>(context, listen: false)
        .substatusListFromScreen
        .clear();
    _statusesToSendFuture = Provider.of<StatusProvider>(context, listen: false)
        .getStatusesToSend(widget.childId!)
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var statusProvider = Provider.of<StatusProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        // extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: DateFormat('d/MMM').format(
            DateTime.now(),
          ),
          titleContainerWidth: 90.w,
          withBackButton: true,
        ),
        bottomNavigationBar: Provider.of<StatusProvider>(context, listen: true)
                .appearSendButton()
            ? null
            : Padding(
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
        body: Localizations.override(
          context: context,
          locale: const Locale('en'),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: FutureBuilder(
                    future: _statusesToSendFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return RippleWidget(
                          height: 0,
                        );
                      }
                      if (statusProvider.hasError) {
                        return CustomErrorWidget();
                      }
                      List<StatusModel> statusesToSend =
                          statusProvider.statusesToSendList;
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) => StatusWidgetToSend(
                          startAnimation: startAnimation,
                          index: i,
                          status: statusesToSend[i],
                        ),
                        itemCount: statusesToSend.length,
                        shrinkWrap: true,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
