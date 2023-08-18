import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/kids/widgets/date_widget.dart';
import 'package:toddily_preschool/main/kids/widgets/dates_screen_button.dart';

class DatesScreen extends StatelessWidget {
  static const routeName = '/dates-screen';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Provider.of<EventProvider>(context).getRole == 0
            ? DatesScreenButton(
                title: 'Monthly Report',
                icon: Icons.health_and_safety_outlined,
                function: () {
                  Navigator.of(context).pushNamed(
                    '/monthly-report-screen',
                  );
                },
              )
            : DatesScreenButton(
                title: 'New Status 25/3',
                icon: Icons.add,
                function: () {
                  Navigator.of(context).pushNamed(
                    '/statuses-screen',
                  );
                },
              ),
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: 'Child Name',
          titleContainerWidth: 130.w,
          withBackButton: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(20.sp),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 1.15.sp,
                    mainAxisSpacing: 15.h,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, i) {
                    _currentIndex = i % characters.length;
                    return DateWidget(
                      image: characters[_currentIndex],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
