import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';

class ImageListScreen extends StatefulWidget {
  static const routeName = 'image-list-screen';
  final List<String>? images;
  int? sentIndex;
  final String? title;

  ImageListScreen({
    this.images,
    this.sentIndex,
    this.title,
  });

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.sentIndex!);
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    bool isPhotosScreen = Provider.of<PhotosProvider>(context).isPhotosScreen;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: isPhotosScreen
              ? AppLocalizations.of(context)!.latestPhotos
              : widget.title!,
          titleContainerWidth: 150.w,
          withBackButton: true,
          stayEnglish: isPhotosScreen ? true : false,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images!.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      widget.images![index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    widget.sentIndex = index;
                  });
                },
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 100.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.images!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: SizedBox(
                        width: 80.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.sp),
                          child: Image.asset(
                            widget.images![index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
