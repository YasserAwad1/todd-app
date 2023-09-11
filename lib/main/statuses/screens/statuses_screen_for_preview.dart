import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';

import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/main/statuses/statusesForPreview/widgets/status_widget_for_preview.dart';
import 'package:toddily_preschool/main/statuses/statusesForPreview/widgets/substatus_widget_for_preview.dart';
import 'package:toddily_preschool/main/statuses/statusesToSend/widgets/status_widget_to_send.dart';
import 'package:toddily_preschool/models/status/status_model.dart';

class StatusesScreenForPreview extends StatefulWidget {
  static const routeName = '/statuses-screen-for-preview';
  String? day;
  String? month;
  int? childId;
  String? date;

  StatusesScreenForPreview({
    this.day,
    this.month,
    this.childId,
    this.date,
  });

  @override
  State<StatusesScreenForPreview> createState() =>
      _StatusesScreenForPreviewState();
}

class _StatusesScreenForPreviewState extends State<StatusesScreenForPreview> {
  bool startAnimation = false;
  var _sentStatusesByDateFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sentStatusesByDateFuture =
        Provider.of<StatusProvider>(context, listen: false)
            .getChildStatusByDate(widget.childId!, widget.date!);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var statusProvider = Provider.of<StatusProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: '${widget.day}/${widget.month}',
          titleContainerWidth: 90.w,
          withBackButton: true,
        ),
        bottomNavigationBar: Provider.of<UserProvider>(context).roleId == 2
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Send Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              )
            : null,
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
                    future: _sentStatusesByDateFuture,
                    builder: (context, snapshot) {
                      if (statusProvider.hasError) {
                        return CustomErrorWidget(height: 0.h,);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return RippleWidget(height: 0.h,);
                      }
                      List<StatusModel> childStatusesByDate =
                          statusProvider.childStatusesByDate;
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) => StatuswidgetForPreview(
                          startAnimation: startAnimation,
                          index: i,
                          status: childStatusesByDate[i],
                        ),
                        itemCount: childStatusesByDate.length,
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
