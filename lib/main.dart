import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//packages
import 'package:firebase_core/firebase_core.dart';
import 'package:toddily_preschool/common/firebaseApi/firebase_api.dart';
import 'package:toddily_preschool/main/kids/dates/screens/dates_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/update_report_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/main/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/main/events/screens/event_images_list_screen.dart';
import 'package:toddily_preschool/main/events/screens/event_photos_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/send_report_screen.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen_to_send.dart';
import 'package:toddily_preschool/main/social_media_expert/screens/pick_image_screen.dart';

//language
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

//Providers
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/main/FAQ/provider/qa_provider.dart';
import 'package:toddily_preschool/main/social_media_expert/providers/kid_image_provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/main/classes/providers/class_provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/kids/dates/providers/dates_provider.dart';
import 'package:toddily_preschool/main/kids/providers/kids_provider.dart';
import 'package:toddily_preschool/main/monthly_report/providers/report_provider.dart';

//screens
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/main/photos/screens/image_list_screen.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';
import 'package:toddily_preschool/main/splash_screen/splash_screen.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen_for_preview.dart';
import 'package:toddily_preschool/main/events/screens/events_screen.dart';
import 'package:toddily_preschool/main/notifications/screens/notifications_screen.dart';
import 'package:toddily_preschool/main/FAQ/screens/FAQScreen.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi.initNotifications();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => AuthProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => PhotosProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => EventProvider(),
              ),
              ChangeNotifierProvider<LanguageProvider>(
                create: (ctx) => LanguageProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => ClassProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => StatusProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => QaProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => UserProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => DatesProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => ReportProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => KidsProvider(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => KidImageProvider(),
              )
            ],
            child: Builder(builder: (context) {
              return MaterialApp(
                title: 'Toddily Preschool',
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: Provider.of<LanguageProvider>(context).currentLocale,
                supportedLocales: L10n.all,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.grey[350],
                    secondary: const Color.fromARGB(255, 255, 207, 58),
                  ),
                ),
                home: SplashScreen(),
                routes: {
                  SplashScreen.routeName: (context) => SplashScreen(),
                  KidsScreen.routeName: (context) => KidsScreen(),
                  DatesScreen.routeName: (context) => DatesScreen(),
                  StatusesScreenForPreview.routeName: (context) =>
                      StatusesScreenForPreview(),
                  PhotosScreen.routeName: (context) => PhotosScreen(),
                  ImageListScreen.routeName: (context) => ImageListScreen(),
                  MonthlyReportScreen.routeName: (context) =>
                      MonthlyReportScreen(),
                  EventsScreen.routeName: (context) => EventsScreen(),
                  AboutScreen.routeName: (context) => AboutScreen(),
                  FAQScreen.routeName: (context) => FAQScreen(),
                  ClassesScreen.routeName: (context) => ClassesScreen(),
                  // ImageSelectionScreen.routeName: (context) =>
                  // ImageSelectionScreen(),
                  // RolesScreen.routeName: (context) => RolesScreen(),
                  // smeImagesScreen.routeName: (context) => smeImagesScreen(),
                  // CameraScreen.routeName: (context) => CameraScreen(),
                  // TakenImagesScreen.routeName: (context) => TakenImagesScreen(),
                  NotificationsScreen.routeName: (context) =>
                      NotificationsScreen(),
                  EventPhotosScreen.routeName: (context) => EventPhotosScreen(),
                  EventImagesListScreen.routeName: (context) =>
                      EventImagesListScreen(),
                  SendReportScreen.routeName: (context) => SendReportScreen(),
                  StatusesScreenToSend.routeName: (context) =>
                      StatusesScreenForPreview(),
                  PickImageScreen.routeName: (context) => PickImageScreen(),
                  UpdateReportScreen.routeName: (context) =>
                      UpdateReportScreen()
                },
              );
            }),
          )),
    );
  }
}
