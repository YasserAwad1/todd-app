import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';

class RolesScreen extends StatefulWidget {
  static const routeName = '/roles-screen';

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            title: 'roles screen',
            titleContainerWidth: 150.w,
            withBackButton: false, withNotification: false,),
        body: ListView(
          children: [
            TextButton(
              onPressed: () {
                {
                  setState(() {
                    Provider.of<EventProvider>(context, listen: false)
                        .setRole(0);
                  });
                }
              },
              child: Text(
                'user',
              ),
            ),
            TextButton(
              onPressed: () {
                {
                  setState(() {
                    Provider.of<EventProvider>(context, listen: false)
                        .setRole(1);
                  });
                }
              },
              child: Text(
                'teacher',
              ),
            ),
            TextButton(
              onPressed: () {
                {
                  setState(() {
                    Provider.of<EventProvider>(context, listen: false)
                        .setRole(2);
                  });
                }
              },
              child: Text(
                'social media expert',
              ),
            )
          ],
        ),
      ),
    );
  }
}
