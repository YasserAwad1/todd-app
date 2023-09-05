import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';
import 'package:toddily_preschool/main/monthly_report/screens/send_report_screen.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/month_tile_widget.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class MonthlyReportScreen extends StatefulWidget {
  KidModel? kid;
  MonthlyReportScreen({
    this.kid,
  });
  static const routeName = '/monthly-report-screen';

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  var _reportsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reportsFuture = Provider.of<ReportProvider>(context, listen: false)
        .getChildReport(widget.kid!.id!);
  }

  Future<void> _refreshData() async {
    print('refreshing');
    await Provider.of<ReportProvider>(context, listen: false)
        .getChildReport(widget.kid!.id!);

    setState(() {
      // Update your data variables
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: 'Monthly Report',
          titleContainerWidth: 180.w,
          withBackButton: true,
          withNotification: true,
        ),
        floatingActionButton: Provider.of<UserProvider>(context, listen: false)
                    .currentUser!
                    .role_id ==
                3
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MyNavigator(
                      screen: SendReportScreen(
                        kid: widget.kid!,
                      ),
                      curves: Curves.easeOutQuint,
                    ),
                  );
                },
                label: Text(
                    'Send report for ${DateFormat.MMMM().format(DateTime.now())}'))
            : null,
        body: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          animSpeedFactor: 4,
          color: Theme.of(context).colorScheme.secondary,
          onRefresh: () {
            return _refreshData();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                FutureBuilder(
                    future: _reportsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Platform.isIOS
                              ? const CupertinoActivityIndicator()
                              : CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                        );
                      }
                      List<ReportModel> reports =
                          Provider.of<ReportProvider>(context, listen: false)
                              .reports;
                      return Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reports.length,
                          itemBuilder: (context, i) => MonthTileWidget(
                            report: reports[i],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
