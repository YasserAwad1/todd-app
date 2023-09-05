import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';

import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/classes/providers/class_provider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/kids/providers/dates_provider.dart';
import 'package:toddily_preschool/main/kids/widgets/date_widget.dart';
import 'package:toddily_preschool/main/kids/widgets/dates_screen_button.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

class DatesScreen extends StatefulWidget {
  KidModel? kid;
  DatesScreen({this.kid});
  static const routeName = '/dates-screen';

  @override
  State<DatesScreen> createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  List<String> characters = [
    'assets/images/characters/dinasour1.png',
    'assets/images/characters/dinasour2.png',
    'assets/images/characters/dinasour3.png',
    'assets/images/characters/elephant.png',
    'assets/images/characters/giraffe.png',
    'assets/images/characters/lion.png',
    'assets/images/characters/monkey.png',
    'assets/images/characters/panda.png',
    'assets/images/characters/rabbit.png',
    'assets/images/characters/squirrel.png',
    'assets/images/characters/tiger.png',
    'assets/images/characters/zibra.png',
  ];

  int _currentIndex = 0;
  bool startAnimation = false;
  var _datesFuture;

  var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
    CurveTween(
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _datesFuture = Provider.of<DatesProvider>(context, listen: false)
        .getDatesByChildId(widget.kid!.id!);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  Future<void> _refreshData() async {
    print('refreshing');
    await Provider.of<ClassProvider>(context, listen: false).getClasses();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Provider.of<UserProvider>(context).reportButton()
            ? DatesScreenButton(
                title: AppLocalizations.of(context)!.monthlyReport,
                icon: Icons.health_and_safety_outlined,
                function: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 450),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MonthlyReportScreen(
                        kid: widget.kid,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: animation.drive(tween),
                          // opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              )
            : Provider.of<UserProvider>(context).roleId == 2
                ? DatesScreenButton(
                    title: 'New Status ${DateFormat('d/M').format(
                      DateTime.now(),
                    )}',
                    icon: Icons.add,
                    function: () {
                      Navigator.of(context).pushNamed(
                        '/statuses-screen',
                      );
                    },
                  )
                : null,
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: widget.kid!.name,
          titleContainerWidth: 130.w,
          withBackButton: true,
        ),
        body: LiquidPullToRefresh(
          onRefresh: () {
            return _refreshData();
          },
          showChildOpacityTransition: false,
          animSpeedFactor: 4,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              FutureBuilder(
                  future: _datesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    List<DateModel> dates =
                        Provider.of<DatesProvider>(context, listen: false)
                            .dates;
                    return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(20.sp),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.w,
                            childAspectRatio: 1.15.sp,
                            mainAxisSpacing: 15.h,
                          ),
                          itemCount: dates.length,
                          itemBuilder: (context, i) {
                            _currentIndex = i % characters.length;
                            return DateWidget(
                              image: characters[_currentIndex],
                              index: i,
                              startAnimation: startAnimation,
                              sentDate: dates[i].date,
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
