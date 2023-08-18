import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/about/widgets/custom_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsList extends StatelessWidget {
  const DetailsList({super.key});

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
    final url = 'https://www.google.com/maps/place/Toddily+preschool/@33.5235236,36.282528,17z/data=!3m1!4b1!4m6!3m5!1s0x1518e7cd493b9de1:0x5266b275441ca30b!8m2!3d33.5235236!4d36.2851029!16s%2Fg%2F11v3yrssd0?authuser=0&entry=ttu';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        CustomTile(
          title: 'Location',
          subtitle:
              'Al Rawda square \nClick to open in maps',
          icon: Icons.location_on_sharp,
          function: () async {
            _launchMapsUrl();
          },
        ),
        CustomTile(
          title: 'Phone Numbers',
          subtitle: '0987056446\n3333110',
          icon: Icons.phone_android_rounded,
        ),
        CustomTile(
          title: 'Open times',
          subtitle: 'Sunday --> Tuesday\n    9 AM --> 5 PM',
          icon: Icons.calendar_month_rounded,
        ),
        CustomTile(
          title: 'WhatsApp',
          subtitle: 'Click to chat',
          image: 'assets/images/socialMedia/whatsappLogo.png',
          function: () async {
            openWhatsapp(context: context, text: '', number: '+963987056446');
          },
        ),
        CustomTile(
          title: 'Instagram',
          subtitle: 'Click to visit page',
          image: 'assets/images/socialMedia/instagramLogo.png',
          function: () async {
            launchInstagramProfile();
          },
        ),
        CustomTile(
          title: 'Facebook',
          subtitle: 'Click to visit page',
          image: 'assets/images/socialMedia/facebookLogo.png',
          function: () async {
            laucnhFacebook();
          },
        ),
      ],
    );
  }
}
