import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/main/social_media_expert/providers/kid_image_provider.dart';

class PickImageScreen extends StatefulWidget {
  static const routeName = '/pick-image-screen';
  KidModel? kid;
  PickImageScreen({
    this.kid,
  });

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final controller = MultiImagePickerController(
      maxImages: 10,
      withReadStream: true,
      allowedImageTypes: ['png', 'jpg', 'jpeg'],
      images: <ImageFile>[]);

  // List<ImageFile>? images;

  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        if (controller.images.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              AppLocalizations.of(context)!.pleaseChooseImage,
            ),
            backgroundColor: Colors.red,
          ));
        } else {
          setState(() {
            stateTextWithIcon = ButtonState.loading;
          });
          Provider.of<KidImageProvider>(context, listen: false).chosenImages =
              controller.images.map((element) => element.path).toList();
          bool success =
              await Provider.of<KidImageProvider>(context, listen: false)
                  .sendKidImages(widget.kid!.id!);

          setState(() {
            stateTextWithIcon =
                success ? ButtonState.success : ButtonState.fail;
            if (stateTextWithIcon == ButtonState.success) {
              Future.delayed(const Duration(milliseconds: 800))
                  .then((value) async {
                Navigator.pop(
                  context,
                  MyNavigator(
                    curves: Curves.easeIn,
                    screen: KidsScreen(),
                  ),
                );
              });
            }
          });
        }

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(
      () {
        stateTextWithIcon = stateTextWithIcon;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: CustomAppBar(
              scaffoldKey: null,
              title: widget.kid!.name,
              titleContainerWidth: 170.w,
              withBackButton: true),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: IconedButton(
                  text: AppLocalizations.of(context)!.send,
                  icon: const Icon(Icons.send, color: Colors.white),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                ButtonState.loading: IconedButton(
                    text: AppLocalizations.of(context)!.loading,
                    color: Theme.of(context).colorScheme.secondary),
                ButtonState.fail: IconedButton(
                    text: AppLocalizations.of(context)!.failed,
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    color: const Color.fromARGB(255, 207, 66, 66)),
                ButtonState.success: IconedButton(
                    text: AppLocalizations.of(context)!.success,
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: onPressedIconWithText,
              state: stateTextWithIcon,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  MultiImagePickerView(
                    onChange: (list) {
                      controller.images;
                    },
                    controller: controller,
                    padding: const EdgeInsets.all(10),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          )),
    );
  }
}
