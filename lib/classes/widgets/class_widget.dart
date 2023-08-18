import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';

class ClassWidget extends StatelessWidget {
  const ClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KidsScreen(
                isComingFromClassesScreen: true,
                classTitle: 'Toddler 1',
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(15.sp),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.sp,
          ),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(6, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Toddler 1',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
