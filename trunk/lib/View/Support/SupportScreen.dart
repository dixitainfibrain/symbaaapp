// ignore_for_file: void_checks

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/FAQ/FAQViewModel.dart';
import 'package:Symbaa/View/ProfileScreen/ProdileViewModel.dart';
import 'package:Symbaa/View/Support/ChatWithUsScreen.dart';
import 'package:Symbaa/View/Support/SupportTicketScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import 'SupportViewModel.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<SupportScreen> with SingleTickerProviderStateMixin {
  SupportViewModel supportViewModel = SupportViewModel();

  @override
  void initState() {
    super.initState();
    supportViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => supportViewModel,
      child: Consumer<SupportViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    NavigatorHelper.remove();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 60, left: 25),
                    width: 140,
                    height: 38,
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            height: 10,
                            width: 10,
                            AssetsHelper.getSVGIcon("ic_back.svg"),
                            color: AppColor.appBlackColor,
                          ),
                        ),
                        CommonWidget.getFieldSpacer(width: 10),
                        Text(
                          buildTranslate(context, 'support'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: commonBackGround(
              context,
              Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Hero(
                      tag: heroMenuItem,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: ShapeDecoration(
                            // color: AppColor.appBlackColor,
                            color: AppColor.appColorCommonContainer,
                            shape: SmoothRectangleBorder(
                                side: BorderSide(width: 1, color: AppColor.appBlackColor),
                                borderRadius: const SmoothBorderRadius.only(
                                    topLeft: SmoothRadius(
                                      cornerRadius: 25,
                                      cornerSmoothing: 0.5,
                                    ),
                                    topRight: SmoothRadius(
                                      cornerRadius: 25,
                                      cornerSmoothing: 0.5,
                                    ))),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.getFieldSpacer(height: 20),
                                Text(
                                  buildTranslate(context, 'needHelpCheckTheseOptions'),
                                  style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 18),
                                ),
                                CommonWidget.getFieldSpacer(height: 25),
                                cardItem(0, () {
                                  return NavigatorHelper().add(const ChatWithUsScreen());
                                }),
                                CommonWidget.getFieldSpacer(height: 20),
                                cardItem(1, () => sendingMails()),
                                CommonWidget.getFieldSpacer(height: 20),
                                cardItem(2, () {
                                  return NavigatorHelper().add(const SupportTicketScreen());
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> sendingMails() async {
    var url = Uri.parse("mailto:divyagohel.infibrain@gmail.com");
    if (await launchUrl(url)) {
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget cardItem(int index, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 75,
        decoration: ShapeDecoration(
          color: AppColor.appWhiteColor,
          shape: SmoothRectangleBorder(
              side: BorderSide(width: 1, color: AppColor.appBlackColor),
              borderRadius: const SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: 12,
                  cornerSmoothing: 0.5,
                ),
              )),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColor.appWhiteColor, width: 0.5),
            color: AppColor.appWhiteColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon(
                    index == 0
                        ? 'ic_chat.svg'
                        : index == 1
                            ? 'ic_email.svg'
                            : 'ic_support_ticket.svg',
                  ),
                  height: 25,
                  width: 25,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buildTranslate(
                            context,
                            index == 0
                                ? 'chatWithUs'
                                : index == 1
                                    ? 'emailUs'
                                    : 'SupportTicket'),
                        style: Fonts.textStyleBold.copyWith(
                          fontSize: 16.5,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 5),
                      Text(
                        buildTranslate(
                            context,
                            index == 0
                                ? 'askUsAnything'
                                : index == 1
                                    ? 'letsGetInTouch'
                                    : 'AskYourQueries'),
                        style: Fonts.textStyleRegular.copyWith(
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SvgPicture.asset(
                AssetsHelper.getSVGIcon("ic_forward.svg"),
                height: 10,
                width: 10,
              ),
              CommonWidget.getFieldSpacer(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
