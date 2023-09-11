import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';

class NoInformationWidget extends StatelessWidget {
  const NoInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context, listen: false).isArabic();
    return Column(
      children: [
        SizedBox(
          height: 170.h,
        ),
        Center(
            child: Image.asset(
          'assets/images/emptyList.png',
          scale: 3.sp,
        )),
        SizedBox(
          height: 20.h,
        ),
        Text(
          AppLocalizations.of(context)!.noInformation,
          style: TextStyle(
            fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
            fontSize: 25.sp,
          ),
        ),
      ],
    );
  }
}
