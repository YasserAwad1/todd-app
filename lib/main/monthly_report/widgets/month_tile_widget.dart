import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthTileWidget extends StatelessWidget {
  const MonthTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      child: ExpansionTile(
        title: const Text(
          'MARCH',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.sp,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.sp,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        children: const [
          Text('a;ldkjls;dfhglksjdfg'),
          Text('a;ldkjls;dfhglksjdfg'),
          Text('a;ldkjls;dfhglksjdfg'),
          Text('a;ldkjls;dfhglksjdfg'),
        ],
      ),
    );
  }
}
