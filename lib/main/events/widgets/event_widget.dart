import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/photos-screen');
        //KEEP FOR TITLE PROBLEM IN PHOTOS SCREEN FOR EVENTS
        // Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => PhotosScreen(
        //             title: 'Event Name',
        //           ),
        //         ));
      },
      child: Container(
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
                child: Image.asset(
                  'assets/images/todd.jpg',
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
                  'Animals Days',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
