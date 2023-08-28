import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/screens/sign_in_screen.dart';
import 'package:toddily_preschool/main/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/social_media_expert/providers/camera_provider.dart';
import 'package:toddily_preschool/social_media_expert/screens/camera_screen.dart';
import 'package:toddily_preschool/social_media_expert/screens/taken_images_screen.dart';

//language
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

//Providers
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';

//screens
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/main/kids/screens/dates_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/main/photos/screens/image_list_screen.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';
import 'package:toddily_preschool/main/splash_screen/splash_screen.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen.dart';
import 'package:toddily_preschool/main/events/screens/events_screen.dart';
import 'package:toddily_preschool/main/notifications/screens/notifications_screen.dart';
import 'package:toddily_preschool/main/FAQ/screens/FAQScreen.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';
import 'package:toddily_preschool/common/screens/image_selection_screen.dart';
import 'package:toddily_preschool/common/screens/roles_screen.dart';
import 'package:toddily_preschool/common/screens/sme_images_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => PhotosProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => EventProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => CameraProvider(),
              ),
              ChangeNotifierProvider<LanguageProvider>(
                create: (ctx) => LanguageProvider(),
              )
            ],
            child: Builder(builder: (context) {
              return MaterialApp(
                title: 'Toddily Preschool',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: Provider.of<LanguageProvider>(context).currentLocale,
                // // localizationsDelegates: const [
                // //   AppLocalizations.delegate,
                // //   GlobalMaterialLocalizations.delegate,
                // //   GlobalWidgetsLocalizations.delegate,
                // //   GlobalCupertinoLocalizations.delegate,
                // // ],
                supportedLocales: L10n.all,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.grey[350],
                    secondary: const Color.fromARGB(255, 255, 207, 58),
                  ),
                  // fontFamily: "LuckiestGuy"
                  // pageTransitionsTheme: PageTransitionsTheme(
                  //   builders: {
                  //     TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  //   },
                  // ),
                ),
                home: SplashScreen(),
                routes: {
                  KidsScreen.routeName: (context) => KidsScreen(),
                  DatesScreen.routeName: (context) => DatesScreen(),
                  StatusesScreen.routeName: (context) => const StatusesScreen(),
                  PhotosScreen.routeName: (context) => PhotosScreen(),
                  ImageListScreen.routeName: (context) => ImageListScreen(),
                  MonthlyReportScreen.routeName: (context) =>
                      MonthlyReportScreen(),
                  EventsScreen.routeName: (context) => EventsScreen(),
                  AboutScreen.routeName: (context) => AboutScreen(),
                  FAQScreen.routeName: (context) => FAQScreen(),
                  ClassesScreen.routeName: (context) => ClassesScreen(),
                  ImageSelectionScreen.routeName: (context) =>
                      ImageSelectionScreen(),
                  RolesScreen.routeName: (context) => RolesScreen(),
                  smeImagesScreen.routeName: (context) => smeImagesScreen(),
                  CameraScreen.routeName: (context) => CameraScreen(),
                  TakenImagesScreen.routeName: (context) => TakenImagesScreen(),
                  NotificationsScreen.routeName: (context) =>
                      NotificationsScreen()
                },
              );
            }),
          )),
    );
  }
}
