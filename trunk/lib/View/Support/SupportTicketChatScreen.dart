import 'dart:ui';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/ValidationHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/Custom/DashedLinePainter.dart';
import 'package:Symbaa/View/Support/GenerateSupportTicketScreen.dart';
import 'package:Symbaa/View/Support/SupportTicketChatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Helper/AssetsHelper.dart';

class SupportTicketChatScreen extends StatefulWidget {
  const SupportTicketChatScreen({super.key});

  @override
  State<SupportTicketChatScreen> createState() => _SupportTicketChatScreenState();
}

class _SupportTicketChatScreenState extends State<SupportTicketChatScreen> {
  SupportTicketChatViewModel supportTicketChatViewModel = SupportTicketChatViewModel();

  @override
  void initState() {
    super.initState();
    supportTicketChatViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => supportTicketChatViewModel,
      child: Consumer<SupportTicketChatViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: InkWell(
                onTap: () {
                  NavigatorHelper.remove();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 60, left: 25, right: 25),
                  decoration:const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/img_theme_bg.png'),
                      fit: BoxFit.fill,
                    )
                  ),
                  //width: 100,
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
                        buildTranslate(context, 'SupportTicket'),
                        style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          NavigatorHelper().add(const GenerateSupportTicketScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appColorCommonContainer,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: AppColor.appWhiteColor,
                                size: 30,
                              ),
                              CommonWidget.getFieldSpacer(width: 10),
                              Text(
                                buildTranslate(context, 'CreteTicket'),
                                style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 16, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: commonBackGround(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.getFieldSpacer(height: 99),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                      child: SingleChildScrollView(
                        physics:const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lorem Ipsum Doler Sit Amet",
                              style: Fonts.textStyleBold.copyWith(color: AppColor.appColorCommonContainer, fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            CommonWidget.getFieldSpacer(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.appWhiteColor,
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
                                    style: Fonts.textStyleRegular.copyWith(
                                      color: AppColor.appColorCommonContainer,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 0.4,
                                      height: 1.5,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 30),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AssetsHelper.getAssetImage(
                                      name: "img_otp1.png",
                                      width: 120.0,
                                      height: 100.0,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  CustomPaint(
                                    size: const Size(double.infinity, 0.5),
                                    painter: DashedLinePainter(
                                      dashWidth: 2.7,
                                      dashSpace: 3.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  Text(
                                    "01 September, 2024",
                                    style: Fonts.textStyleRegular.copyWith(
                                      color: AppColor.appColorCommonContainer,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 0.4,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidget.getFieldSpacer(height: 20),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor.appWhiteColor,
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
                                      style: Fonts.textStyleRegular.copyWith(
                                        color: AppColor.appColorCommonContainer,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: 0.4,
                                        height: 1.5,
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(height: 10),
                                    CustomPaint(
                                      size: const Size(double.infinity, 0.5),
                                      painter: DashedLinePainter(
                                        dashWidth: 2.7,
                                        dashSpace: 3.5,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(height: 10),
                                    Text(
                                      "01 September, 2024",
                                      style: Fonts.textStyleRegular.copyWith(
                                        color: AppColor.appColorCommonContainer,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: 0.4,
                                        height: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CommonWidget.getFieldSpacer(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.appWhiteColor,
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
                                    style: Fonts.textStyleRegular.copyWith(
                                      color: AppColor.appColorCommonContainer,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 0.4,
                                      height: 1.5,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 30),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AssetsHelper.getAssetImage(
                                      name: "img_otp1.png",
                                      width: 120.0,
                                      height: 100.0,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  CustomPaint(
                                    size: const Size(double.infinity, 0.5),
                                    painter: DashedLinePainter(
                                      dashWidth: 2.7,
                                      dashSpace: 3.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  Text(
                                    "01 September, 2024",
                                    style: Fonts.textStyleRegular.copyWith(
                                      color: AppColor.appColorCommonContainer,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 0.4,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: AppColor.appWhiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12),
                    child: TextFormField(
                      controller: supportTicketChatViewModel.replyCtrl,
                      focusNode: supportTicketChatViewModel.replyFocus,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColor.appBlackColor,
                      decoration: InputDecoration(
                        hintText: buildTranslate(context, 'reply'),
                        hintStyle: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appColorCommonContainer),
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColor.appCurveBorderColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColor.appCurveBorderColor, width: 1.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SvgPicture.asset(
                                AssetsHelper.getSVGIcon(
                                  'ic_clip.svg',
                                ),
                                height: 25,
                                width: 25,
                              ),
                              CommonWidget.getFieldSpacer(width: 14),
                              SvgPicture.asset(
                                AssetsHelper.getSVGIcon(
                                  'ic_send.svg',
                                ),
                                height: 25,
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
