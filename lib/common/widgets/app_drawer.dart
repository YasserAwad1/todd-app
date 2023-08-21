import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color yellow = Theme.of(context).colorScheme.secondary;

    return Drawer(
      width: 270.w,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 126.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              color: yellow,
            ),
            child: Container(
                margin: EdgeInsets.all(15.sp),
                child: Image.asset(
                  'assets/images/ToddilyLogo.png',
                  fit: BoxFit.fill,
                )),
          ),
          //CLASSES TILE FOR DOCTOR AND SOCIAL MEDIA EXPERT
          if (Provider.of<EventProvider>(context).getRole == 2)
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.class_outlined,
                    color: yellow,
                    size: 26.sp,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      const Text(
                        'Classes',
                        style: TextStyle(
                          fontFamily: "LuckiestGuy",
                        ),
                      ),
                    ],
                  ),
                  splashColor: yellow.withOpacity(0.9),
                  onTap: () async {
                    Navigator.pop(context);
                    await Future.delayed(
                        const Duration(milliseconds: 50)); // wait some time
                    Navigator.pushReplacementNamed(
                      context,
                      '/classes-screen',
                    );
                  },
                ),
                Divider(
                  color: yellow,
                  thickness: 0.3.h,
                ),
              ],
            ),
          //KIDS TILE
          ListTile(
            leading: Icon(
              Icons.person_outline_rounded,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  'Kids',
                  style: TextStyle(
                    fontFamily: "LuckiestGuy",
                  ),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () async {
              Navigator.pop(context);
              await Future.delayed(
                  const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacementNamed(
                context,
                '/kids-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //LATEST PHOTOS TILE
          ListTile(
            leading: Icon(
              Icons.photo_library_outlined,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  'Latest Photos',
                  style: TextStyle(
                    fontFamily: "LuckiestGuy",
                  ),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Provider.of<PhotosProvider>(context, listen: false)
                  .triggerPhotosScreen();
              // Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotosScreen(),
                  ));
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //EVENTS TILE
          ListTile(
            leading: Icon(
              Icons.event,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  'Events',
                  style: TextStyle(
                    fontFamily: "LuckiestGuy",
                  ),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Provider.of<PhotosProvider>(context, listen: false)
                  .triggerEventsScreen();
              Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacementNamed(
                context,
                '/events-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //ABOUT TODDILY PRESCHOOL TILE
          ListTile(
            leading: Icon(
              Icons.warning_amber_sharp,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  'About Toddily Preschool',
                  style: TextStyle(
                    fontFamily: "LuckiestGuy",
                  ),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacementNamed(
                context,
                '/about-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //FREQUENTLY ASKED QUESTIONS TILE
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: yellow,
              size: 26.sp,
            ),
            title: const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontFamily: "LuckiestGuy",
              ),
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                '/FAQ-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: yellow,
              size: 26.sp,
            ),
            title: const Text(
              'Roles',
              style: TextStyle(
                fontFamily: "LuckiestGuy",
              ),
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                '/roles-screen',
              );
            },
          ),

          SizedBox(
            height: 10.h,
          ),

          //BUTTONS ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: yellow),
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "LuckiestGuy",
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "LuckiestGuy",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
