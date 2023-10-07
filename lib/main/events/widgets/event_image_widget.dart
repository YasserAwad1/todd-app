import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/widgets/app_place_holder.dart';
import 'package:toddily_preschool/main/events/screens/event_images_list_screen.dart';
import 'package:toddily_preschool/models/events/event_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class EventImageWidget extends StatefulWidget {
  String image;
  bool startAnimation;
  int index;
  EventModel? event;
  EventImageWidget(
      {required this.image,
      required this.index,
      required this.startAnimation,
      required this.event});

  @override
  State<EventImageWidget> createState() => _EventImageWidgetState();
}

class _EventImageWidgetState extends State<EventImageWidget> {
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
      // print('Failed to download image. Status code: ${response.statusCode}');
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
              builder: (context) => EventImagesListScreen(
                sentIndex: widget.index,
                event: widget.event!,
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
              0),
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
                  frameBuilder: (_, image, loadingBuilder, __) {
                    if (loadingBuilder == null) {
                      return AppPlaceholder(
                          child: Container(
                        color: Colors.white,
                        height: 200.h,
                      ));
                    }
                    return image;
                  },
                  errorBuilder: (context, error, stackTrace) => Image(
                    image: AssetImage('assets/images/errorImage.png'),
                    height: 160.h,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: isArabic ? null : 0,
                left: isArabic ? 0 : null,
                child: isDownloading
                    ? Platform.isIOS
                        ? CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.secondary)
                        : CircularProgressIndicator(
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
