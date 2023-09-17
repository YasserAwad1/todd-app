import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/FAQ/provider/qa_provider.dart';
import 'package:toddily_preschool/main/FAQ/widgets/faq_tile.dart';
import 'package:toddily_preschool/main/FAQ/widgets/custom_slimy_card.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/month_tile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FAQScreen extends StatefulWidget {
  static const routeName = '/FAQ-screen';

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _qaFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qaFuture = Provider.of<QaProvider>(context, listen: false)
        .getQuestionsAndAnswers();
  }

  Future<void> _refreshData() async {
    print('refreshing');
    await Provider.of<QaProvider>(context, listen: false)
        .getQuestionsAndAnswers();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: AppLocalizations.of(context)!.faqs,
          titleContainerWidth: 150.w,
          withBackButton: false,
          withNotification: true,
          stayEnglish: true,
        ),
        drawerEdgeDragWidth: 200.w,
        drawerEnableOpenDragGesture: true,
        body: Localizations.override(
          context: context,
          locale: const Locale('en'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LiquidPullToRefresh(
              onRefresh: () {
                return _refreshData();
              },
              animSpeedFactor: 4,
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                        future: _qaFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return RippleWidget(height: 0,);
                          }
                          if (Provider.of<QaProvider>(context, listen: false)
                              .hasError) {
                            return Localizations.override(
                                context: context,
                                locale: Provider.of<LanguageProvider>(context,
                                        listen: false)
                                    .getCurrentLocal(),
                                child: CustomErrorWidget(height: 0,));
                          }
                          final qaList =
                              Provider.of<QaProvider>(context, listen: false)
                                  .qaList;
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: qaList.length,
                            itemBuilder: (context, i) => CustomSlimyCard(
                              question: qaList[i].question,
                              answer: qaList[i].answer,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
