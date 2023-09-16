import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/kids/screens/dates_screen.dart';
import 'package:toddily_preschool/main/kids/screens/kid_photos_screen.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class datesScreenView extends StatelessWidget {
  KidModel? kid;
  static const routeName = '/dates-screen-view';

  datesScreenView({this.kid});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();
    return SafeArea(
      top: Platform.isIOS ? false : true,
      bottom: Platform.isIOS ? false : true,
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: kid!.name,
          titleContainerWidth: 230.w,
          withBackButton: true,
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(12.sp),
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: TabBar(
                  labelStyle: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: isArabic ? "Lalezar" : "LuckiestGuy"),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color.fromRGBO(112, 112, 112, 1),
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context)!.statuses,
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.photos,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DatesScreen(kid: kid),
                    KidPhotosScreen(
                      kid: kid,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
