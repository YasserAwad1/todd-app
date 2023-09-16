import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/main/kids/screens/kid_image_list_screen.dart';
import 'package:toddily_preschool/main/photos/screens/image_list_screen.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:toddily_preschool/social_media_expert/providers/kid_image_provider.dart';

class KidImageWidgetToCheck extends StatefulWidget {
  final String? title;
  bool startAnimation;
  int index;
  String image;
  int imageId;
  int childId;
  List<KidImageModel> images;

  KidImageWidgetToCheck(
      {required this.startAnimation,
      required this.index,
      this.title,
      required this.childId,
      required this.imageId,
      required this.image,
      required this.images});

  @override
  State<KidImageWidgetToCheck> createState() => _KidImageWidgetToCheckState();
}

class _KidImageWidgetToCheckState extends State<KidImageWidgetToCheck> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();

    return Padding(
      padding: EdgeInsets.only(top: 8.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KidImageListScreen(
                images: widget.images,
                sentIndex: widget.index,
                title: widget.title,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          curve: Curves.easeOutSine,
          duration: Duration(
            milliseconds: 500 + (widget.index * 100),
          ),
          transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0,
          ),
          width: double.infinity,
          height: 150.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.sp),
                child: Image.network(
                  '${Endpoints.baseUrl}${widget.image}',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 0,
                right: isArabic ? null : 0,
                left: isArabic ? 0 : null,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      Provider.of<KidImageProvider>(context, listen: false)
                          .isLoading = true;
                    });
                    bool success = await Provider.of<KidImageProvider>(context,
                            listen: false)
                        .checkImage(widget.imageId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: success
                            ? Colors.green.shade400
                            : Colors.red.shade300,
                        content: Text(
                          success
                              ? 'Image checked successfully'
                              : 'Error in checking image',
                        ),
                      ),
                    );
                    if (success) {
                      await Provider.of<KidImageProvider>(context,
                              listen: false)
                          .getKidImagesToCheck(widget.childId);
                    }
                    setState(() {
                      Provider.of<KidImageProvider>(context, listen: false)
                          .isLoading = false;
                    });
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: isArabic ? 0 : null,
                left: isArabic ? null : 0,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      Provider.of<KidImageProvider>(context, listen: false)
                          .isLoading = true;
                    });
                    bool success = await Provider.of<KidImageProvider>(context,
                            listen: false)
                        .checkImage(widget.imageId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: success
                            ? Colors.green.shade400
                            : Colors.red.shade300,
                        content: Text(
                          success
                              ? 'Image deleted successfully'
                              : 'Error in deleting image',
                        ),
                      ),
                    );
                    if (success) {
                      await Provider.of<KidImageProvider>(context,
                              listen: false)
                          .getKidImagesToCheck(widget.childId);
                    }
                    setState(() {
                      Provider.of<KidImageProvider>(context, listen: false)
                          .isLoading = false;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
