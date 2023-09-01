import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';

class EventImagesListScreen extends StatefulWidget {
  static const routeName = '/event-images-list-screen';
  int? sentIndex;
  String? eventName;
  EventImagesListScreen({
    this.sentIndex,
    this.eventName,
  });

  @override
  State<EventImagesListScreen> createState() => EventImagesListScreenState();
}

class EventImagesListScreenState extends State<EventImagesListScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.sentIndex!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: widget.eventName!,
          titleContainerWidth: 150.w,
          withBackButton: true,
          stayEnglish: true,
        ),
        body: Column(
          children: [
          //   Expanded(
          //     child: PageView.builder(
          //       controller: _pageController,
          //       itemCount: widget.images!.length,
          //       itemBuilder: (context, index) {
          //         return Center(
          //           child: Image.asset(
          //             widget.images![index],
          //             fit: BoxFit.contain,
          //           ),
          //         );
          //       },
          //       onPageChanged: (index) {
          //         setState(() {
          //           widget.sentIndex = index;
          //         });
          //       },
          //     ),
          //   ),
          //   Container(
          //     color: Theme.of(context).colorScheme.secondary,
          //     height: 100.h,
          //     child: ListView.builder(
          //       physics: const BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: widget.images!.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: EdgeInsets.all(8.0.sp),
          //           child: GestureDetector(
          //             onTap: () {
          //               _pageController.animateToPage(
          //                 index,
          //                 duration: const Duration(milliseconds: 500),
          //                 curve: Curves.easeInOut,
          //               );
          //             },
          //             child: SizedBox(
          //               width: 80.w,
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(15.sp),
          //                 child: Image.asset(
          //                   widget.images![index],
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          ],
        ),
      ),
    );
  }
}
