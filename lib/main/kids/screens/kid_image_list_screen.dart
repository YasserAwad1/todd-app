import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';

import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class KidImageListScreen extends StatefulWidget {
  static const routeName = 'image-list-screen';
  List<KidImageModel>? images;
  int? sentIndex;
  final String? title;

  KidImageListScreen({
    this.images,
    this.sentIndex,
    this.title,
  });

  @override
  _KidImageListScreenState createState() => _KidImageListScreenState();
}

class _KidImageListScreenState extends State<KidImageListScreen> {
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

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: null,
          title: AppLocalizations.of(context)!.latestPhotos,
          titleContainerWidth: 150.w,
          withBackButton: true,
          stayEnglish: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images!.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.network(
                      '${Endpoints.baseUrl}${widget.images![index].image}',
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
                          child: Image.network(
                            '${Endpoints.baseUrl}${widget.images![index].image}',
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
