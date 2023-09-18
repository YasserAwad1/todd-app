import 'package:flutter/material.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

//widgets
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/kids/providers/kids_provider.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_widget.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/main/social_media_expert/providers/kid_image_provider.dart';

class KidsScreen extends StatefulWidget {
  static const routeName = '/kids-screen';
  bool? isComingFromClassesScreen = false;
  String? classTitle;
  int? classId;
  List<KidModel>? kidsOfClasses;

  KidsScreen(
      {this.isComingFromClassesScreen = false,
      this.classTitle,
      this.kidsOfClasses,
      this.classId});

  @override
  State<KidsScreen> createState() => _KidsScreenState();
}

class _KidsScreenState extends State<KidsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _kidsFuture;

  bool startAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Provider.of<UserProvider>(context, listen: false).teacherOrParent()) {
      var userId =
          Provider.of<UserProvider>(context, listen: false).getCurrentUserId();
      _kidsFuture = Provider.of<KidsProvider>(context, listen: false)
          .getChildrenByTeachOrParentId(userId!);
    } else if (Provider.of<UserProvider>(context, listen: false)
            .getUserRoleId() ==
        6) {
      _kidsFuture =
          Provider.of<KidsProvider>(context, listen: false).getExtrasChildren();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Provider.of<KidImageProvider>(context, listen: false)
                .getKidImagesToCheck(13);
          },
        ),
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: widget.isComingFromClassesScreen == true
              ? widget.classTitle!
              : AppLocalizations.of(context)!.kids,
          titleContainerWidth: 100.w,
          withBackButton: widget.isComingFromClassesScreen ?? false,
          stayEnglish: true,
          withNotification: true,
        ),
        drawer: AppDrawer(),
        body: Container(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Image.asset('assets/images/pens.png'),
                  ),
                ],
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    if (widget.isComingFromClassesScreen!)
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.kidsOfClasses!.length,
                        itemBuilder: (context, i) => KidsWidget(
                          startAnimation: startAnimation,
                          index: i,
                          kid: widget.kidsOfClasses![i],
                          classTitle: widget.classTitle!,
                        ),
                      ),
                    if (!widget.isComingFromClassesScreen!)
                      FutureBuilder(
                          future: _kidsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return RippleWidget();
                            } else if (Provider.of<KidsProvider>(context,
                                    listen: false)
                                .hasError) {
                              return CustomErrorWidget();
                            }

                            List<KidModel> kids = Provider.of<UserProvider>(
                                        context,
                                        listen: false)
                                    .teacherOrParent()
                                ? Provider.of<KidsProvider>(context,
                                        listen: false)
                                    .kids
                                : Provider.of<KidsProvider>(context,
                                        listen: false)
                                    .extraChildren;
                            return ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: kids.length,
                              itemBuilder: (context, i) => KidsWidget(
                                startAnimation: startAnimation,
                                index: i,
                                classTitle: kids[i].className!,
                                kid: kids[i],
                              ),
                            );
                          }),
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
