import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/main/kids/screens/kid_image_list_screen.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class KidImageWidget extends StatefulWidget {
  final String? title;
  bool startAnimation;
  int index;
  String image;
  List<KidImageModel> images;

  KidImageWidget(
      {required this.startAnimation,
      required this.index,
      this.title,
      required this.image,
      required this.images});

  @override
  State<KidImageWidget> createState() => _KidImageWidgetState();
}

class _KidImageWidgetState extends State<KidImageWidget> {
  bool isDownloading = false;

  Future<bool> downloadAndSaveImage(String imageUrl) async {
    setState(() {
      isDownloading = true;
    });
    var response = await http.get(Uri.parse('${Endpoints.baseUrl}$imageUrl'));

    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      await ImageGallerySaver.saveImage(bytes);
      setState(() {
        isDownloading = false;
      });
      return true;
    } else {
      
      print('Failed to download image. Status code: ${response.statusCode}');
      setState(() {
        isDownloading = false;
      });
      return false;
    }
  }

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
                child: isDownloading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : Container(
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(isArabic ? 0 : 10.sp),
                            topRight: Radius.circular(isArabic ? 0 : 15.sp),
                            bottomRight: Radius.circular(isArabic ? 10.sp : 0),
                            topLeft: Radius.circular(isArabic ? 15.sp : 0),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            bool savedImage =
                                await downloadAndSaveImage(widget.image);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: savedImage
                                    ? Colors.green.shade400
                                    : Colors.red.shade300,
                                content: Text(
                                  savedImage
                                      ? AppLocalizations.of(context)!
                                          .imageDownloadedSuc
                                      : AppLocalizations.of(context)!
                                          .errorOccuredWhileDownloadingImage,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.download,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 28.sp,
                          ),
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
