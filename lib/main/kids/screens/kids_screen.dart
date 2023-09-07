import 'package:flutter/material.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';

//widgets
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_widget.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

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

  bool startAnimation = false;
  KidModel kid = KidModel(
      name: 'yasser awad',
      image: '',
      isExtra: 0,
      parent_id: 3,
      classRoom_id: 1);
  // var _classFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _classFuture = Provider.of<ClassProvider>(context, listen: false)
    //     .getClassById(widget.classId!);
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
        // backgroundColor: Color.fromARGB(255, 3, 1, 116),
        extendBodyBehindAppBar: false,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Provider.of<StatusProvider>(context, listen: false).getStatuses();
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
        ),
        drawer: AppDrawer(),
        body: Container(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  Spacer(),
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
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, i) => KidsWidget(
                          startAnimation: startAnimation,
                          index: i,
                          classTitle: 'class',
                          kid: kid,
                        ),
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
