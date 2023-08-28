import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10.w,
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          height: 1.5.h,
          width: 130.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          AppLocalizations.of(context)!.or,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          height: 1.5.h,
          width: 130.w,
        ),
      ],
    );
  }
}
