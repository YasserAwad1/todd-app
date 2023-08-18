import 'package:flutter/material.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/common/screens/camera_example_home.dart';
import 'package:toddily_preschool/common/screens/image_selection_screen.dart';
import 'package:toddily_preschool/common/screens/roles_screen.dart';
import 'package:toddily_preschool/common/screens/sme_images_screen.dart';
import 'package:toddily_preschool/main/FAQ/screens/FAQScreen.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';

//Providers
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';

//screens
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/main/kids/screens/dates_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/main/photos/screens/image_list_screen.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen.dart';
import 'package:toddily_preschool/main/events/screens/events_screen.dart';

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
            ],
            child: Builder(builder: (context) {
              return MaterialApp(
                title: 'Toddily Preschool',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.grey[350],
                    secondary: const Color.fromARGB(255, 255, 207, 58),
                  ),
                ),
                home: KidsScreen(),
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
                  smeImagesScreen.routeName : (context) => smeImagesScreen(),
                  CameraExampleHome.routeName: (context) => CameraExampleHome(),
                },
              );
            }),
          )),
    );
  }
}
