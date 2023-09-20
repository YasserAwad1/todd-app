import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';

class LanguageButtons extends StatelessWidget {
  bool isArabic;
  LanguageButtons({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          // LANGUAGE
          child: Row(
            children: [
              Text(
                '${AppLocalizations.of(context)!.language}  ',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                ),
              ),
              const Icon(Icons.language_rounded)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async{
                await Provider.of<LanguageProvider>(context, listen: false)
                    .changeLocale('en');
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.w,
                    color: isArabic
                        ? Colors.black
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'English',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async{
                await Provider.of<LanguageProvider>(context, listen: false)
                    .changeLocale('ar');
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.w,
                    color: isArabic
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Arabic',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
