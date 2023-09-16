import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/models/classes/class_model.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

class ClassWidget extends StatelessWidget {
  int index;
  bool startAnimation;
  ClassModel classModel;
  ClassWidget({
    required this.index,
    required this.startAnimation,
    required this.classModel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MyNavigator(
            screen: KidsScreen(
              isComingFromClassesScreen: true,
              classTitle: classModel.name,
              classId: classModel.id,
              kidsOfClasses: classModel.children,
            ),
            curves: Curves.easeOutBack,
          ),
        );
      },
      child: AnimatedContainer(
        curve: Curves.easeOutSine,
        duration: Duration(
          milliseconds: 500 + (index * 100),
        ),
        transform: Matrix4.translationValues(
          startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
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
            classModel.name,
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
