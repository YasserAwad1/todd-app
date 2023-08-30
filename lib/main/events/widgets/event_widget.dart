import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';
import 'package:toddily_preschool/models/events/event_model.dart';

class EventWidget extends StatelessWidget {
  bool startAnimation;
  int index;
  EventModel event;
  EventWidget(
      {required this.startAnimation, required this.index, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PhotosProvider>(context, listen: false)
            .triggerEventsScreen();
        Navigator.push(
          context,
          MyNavigator(
            screen: PhotosScreen(event: event),
            curves: Curves.bounceIn,
          ),
        );
      },
      child: AnimatedContainer(
        curve: Curves.easeOutSine,
        duration: Duration(
          milliseconds: 500 + (index * 100),
        ),
        transform: Matrix4.translationValues(
            startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.9,
              blurRadius: 10,
              offset: Offset(6, 7),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  topRight: Radius.circular(15.sp),
                ),
                child: Image.network(
                  '${Endpoints.baseUrl}${event.image_cover}',
                  fit: BoxFit.fill,
                  width: double.infinity.w,
                ),
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 30.h,
              child: Center(
                child: Text(
                  event.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
