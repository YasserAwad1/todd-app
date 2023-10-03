import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/events/widgets/event_widget.dart';
import 'package:toddily_preschool/models/events/event_model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events-screen';

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _eventFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventFuture = Provider.of<EventProvider>(context, listen: false)
        .getEvents()
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<EventProvider>(context, listen: false).getEvents();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: AppLocalizations.of(context)!.events,
          titleContainerWidth: 100.w,
          withBackButton: false,
          stayEnglish: true,
        ),
        body: LiquidPullToRefresh(
          onRefresh: () {
            return _refreshData();
          },
          animSpeedFactor: 4,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: FutureBuilder(
                    future: _eventFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return RippleWidget(
                          height: 0,
                        );
                      }
                      if (Provider.of<EventProvider>(context, listen: false)
                          .hasError) {
                        return CustomErrorWidget(
                          height: 0,
                        );
                      }
                      List<EventModel> events =
                          Provider.of<EventProvider>(context, listen: false)
                              .events
                              .reversed
                              .toList();
                      if (events.isEmpty) {
                        return NoInformationWidget();
                      }
                      return GridView.builder(
                        padding: EdgeInsets.all(12.sp),
                        shrinkWrap: true,
                        itemCount: events.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2.sp,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 20.w,
                        ),
                        itemBuilder: (context, i) => EventWidget(
                          startAnimation: startAnimation,
                          index: i,
                          event: events[i],
                        ),
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
