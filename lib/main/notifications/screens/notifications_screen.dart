import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications-screen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: AppLocalizations.of(context)!.notifications,
          titleContainerWidth: 150.w,
          withBackButton: true,
          withNotification: false,
          stayEnglish: true,
        ),
        body: Center(
          child: Text('noti screen'),
        ),
      ),
    );
  }
}
