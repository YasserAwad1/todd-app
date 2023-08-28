import 'package:flutter/material.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//widgets
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_widget.dart';

class KidsScreen extends StatefulWidget {
  static const routeName = '/kids-screen';
  bool? isComingFromClassesScreen = false;
  String? classTitle;

  KidsScreen({this.isComingFromClassesScreen, this.classTitle});

  @override
  State<KidsScreen> createState() => _KidsScreenState();
}

class _KidsScreenState extends State<KidsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 3, 1, 116),
        extendBodyBehindAppBar: false,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: widget.isComingFromClassesScreen != null
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
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, i) => KidsWidget(
                        startAnimation: startAnimation,
                        index: i,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Column(
        //   children: [
        //     SizedBox(
        //       height: 15.h,
        //     ),
        //     // IF MORE THAN ONE KID
        //     Expanded(
        //       child: ListView.builder(
        //         physics: const ScrollPhysics(),
        //         shrinkWrap: true,
        //         itemCount: 20,
        //         itemBuilder: (context, i) => KidsWidget(),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        //       child: Image.asset('assets/images/pens.png'),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
