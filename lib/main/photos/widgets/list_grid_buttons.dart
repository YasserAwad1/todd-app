import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';

class ListGridButtons extends StatefulWidget {
  bool isList;
  ListGridButtons({
    required this.isList,
  });

  @override
  State<ListGridButtons> createState() => _ListGridButtonsState();
}

class _ListGridButtonsState extends State<ListGridButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //LIST BUTTON
        Container(
          padding: EdgeInsets.all(2.sp),
          height: 45.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(
                style: widget.isList ? BorderStyle.solid : BorderStyle.none,
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(
                        0.7,
                      ),
            ),
            onPressed: () {
              setState(() {
                Provider.of<PhotosProvider>(context, listen: false).changeListGridView();
              });
            },
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            ),
            //  LIST
            label: Text(
              AppLocalizations.of(context)!.list,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //GRID BUTTON
        Container(
          padding: EdgeInsets.all(2.sp),
          height: 45.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
                style: widget.isList ? BorderStyle.none : BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(
                        0.7,
                      ),
            ),
            onPressed: () {
              setState(() {
                Provider.of<PhotosProvider>(context, listen: false).changeListGridView();
              });
            },
            icon: const Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
            //  LIST
            label: Text(
              AppLocalizations.of(context)!.grid,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
