import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/notifications/providers/notification_provider.dart';
import 'package:toddily_preschool/main/notifications/widgets/notification_widget.dart';
import 'package:toddily_preschool/models/notifications/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications-screen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _notificationsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationsFuture =
        Provider.of<NotificationProvider>(context, listen: false)
            .getNotifications();
  }

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
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            FutureBuilder(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return RippleWidget();
                  }
                  if (Provider.of<NotificationProvider>(context, listen: false)
                      .hasError) {
                    return CustomErrorWidget();
                  }
                  List<NotificationModel> notifications =
                      Provider.of<NotificationProvider>(context, listen: false)
                          .notifications.reversed.toList();
                  if (notifications.isEmpty) {
                    return NoInformationWidget();
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return NotificationWidget(
                          notification: notifications[i],
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
