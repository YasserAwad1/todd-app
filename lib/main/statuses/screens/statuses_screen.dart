import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/statuses/widgets/status_widget.dart';

class StatusesScreen extends StatefulWidget {
  static const routeName = '/statuses-screen';
  const StatusesScreen({super.key});

  @override
  State<StatusesScreen> createState() => _StatusesScreenState();
}

class _StatusesScreenState extends State<StatusesScreen> {
  bool startAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: '24/MAR',
          titleContainerWidth: 90.w,
          withBackButton: true,
        ),
        bottomNavigationBar: Provider.of<EventProvider>(context).getRole == 1
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
                child: ListView.builder(
                  itemBuilder: (context, i) => StatusWidget(
                    startAnimation: startAnimation,
                    index: i,
                  ),
                  itemCount: 2,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
