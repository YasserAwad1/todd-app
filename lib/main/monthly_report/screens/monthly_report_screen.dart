import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';
import 'package:toddily_preschool/main/monthly_report/screens/send_report_screen.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/custom_expandable_tile.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/models/report/report_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Future<void> refreshData() async {
    print('refreshing');
    await Provider.of<ReportProvider>(context, listen: false)
        .getChildReport(widget.kid!.id!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: AppLocalizations.of(context)!.monthlyReport,
          titleContainerWidth: 180.w,
          withBackButton: true,
          withNotification: true,
          stayEnglish: true,
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
                        isEditing: false,
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
          animSpeedFactor: 4,
          color: Theme.of(context).colorScheme.secondary,
          onRefresh: () {
            return refreshData();
          },
          child: Padding(
            padding: EdgeInsets.all(5.0.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Consumer<ReportProvider>(builder: (context, reportProvider, _) {
                  return FutureBuilder(
                      future: _reportsFuture,
                      builder: (context, snapshot) {
                        if (reportProvider.isLoading) {
                          return RippleWidget();
                        }
                        if (reportProvider.hasError) {
                          return CustomErrorWidget();
                        }
                        List<ReportModel> reports = reportProvider.reports.reversed.toList();
                        if (reports.isEmpty) {
                          return NoInformationWidget();
                        }
                        return Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: reports.length,
                            itemBuilder: (context, i) => CustomExpandableTile(
                              report: reports[i],
                              kid: widget.kid!,
                            ),
                          ),
                        );
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
