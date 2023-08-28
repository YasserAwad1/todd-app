import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/about/widgets/custom_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsList extends StatefulWidget {
  const DetailsList({super.key});

  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
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

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(
            Uri.parse(
              whatsappURLIos,
            ),
            mode: LaunchMode.externalNonBrowserApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(
          Uri.parse(whatsappURlAndroid),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  void launchInstagramProfile() async {
    String url = 'https://www.instagram.com/toddily_preschool';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch instagram account';
    }
  }

  void laucnhFacebook() async {
    String url =
        'https://www.facebook.com/profile.php?id=100083077104926&mibextid=ZbWKwL';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch facebook account';
    }
  }

  void _launchMapsUrl() async {
    final url =
        'https://www.google.com/maps/place/Toddily+preschool/@33.5235236,36.282528,17z/data=!3m1!4b1!4m6!3m5!1s0x1518e7cd493b9de1:0x5266b275441ca30b!8m2!3d33.5235236!4d36.2851029!16s%2Fg%2F11v3yrssd0?authuser=0&entry=ttu';
    if (await canLaunchUrl(
      Uri.parse(
        url,
      ),
    )) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [
      //LOCATION
      CustomTile(
        title: AppLocalizations.of(context)!.location,
        subtitle:
            '${AppLocalizations.of(context)!.todLocation}\n${AppLocalizations.of(context)!.openInMaps}',
        icon: Icons.location_on_sharp,
        function: () async {
          _launchMapsUrl();
        },
      ),
      //PHONE NUMBERS
      CustomTile(
        title: AppLocalizations.of(context)!.phonenums,
        subtitle: '0987056446\n3333110',
        icon: Icons.phone_android_rounded,
      ),
      //OPEN TIMES
      CustomTile(
        title: AppLocalizations.of(context)!.openTimes,
        subtitle:
            '  ${AppLocalizations.of(context)!.openDays}\n${AppLocalizations.of(context)!.openHours}',
        icon: Icons.calendar_month_rounded,
      ),
      //WHATSAPP
      CustomTile(
        title: AppLocalizations.of(context)!.whatsapp,
        subtitle: AppLocalizations.of(context)!.clickToChat,
        image: 'assets/images/socialMedia/whatsappLogo.png',
        function: () async {
          openWhatsapp(context: context, text: '', number: '+963987056446');
        },
      ),
      //INSTAGRAM
      CustomTile(
        title: AppLocalizations.of(context)!.instagram,
        subtitle: AppLocalizations.of(context)!.clickToVisitPage,
        image: 'assets/images/socialMedia/instagramLogo.png',
        function: () async {
          launchInstagramProfile();
        },
      ),
      //FACEBOOK
      CustomTile(
        title: AppLocalizations.of(context)!.facebook,
        subtitle: AppLocalizations.of(context)!.clickToVisitPage,
        image: 'assets/images/socialMedia/facebookLogo.png',
        function: () async {
          laucnhFacebook();
        },
      ),
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tiles.length,
      itemBuilder: (context, i) {
        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(
            milliseconds: 500 + (i * 200),
          ),
          transform: Matrix4.translationValues(
              startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
          child: tiles[i],
        );
      },
    );
  }
}
