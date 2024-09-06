import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/RechargeScreen/RechargePlanViewModel.dart';
import 'package:Symbaa/View/ShopScreen/CardDetailScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Localization/languageSettings.dart';

class RechargePlanScreen extends StatefulWidget {
  const RechargePlanScreen({super.key});

  @override
  State<RechargePlanScreen> createState() => _RechargePlanScreenState();
}

class _RechargePlanScreenState extends State<RechargePlanScreen> {
  RechargePlanViewModel rechargePlanViewModel = RechargePlanViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => rechargePlanViewModel,
      child: Consumer<RechargePlanViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(top: 62, left: 10, bottom: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          NavigatorHelper.remove();
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: AppColor.appBlackColor,
                      ),
                      Text(
                        buildTranslate(context, 'selectRechargePlan'),
                        style: Fonts.textStyleRegular.copyWith(fontSize: 18),
                      ),
                    ],
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: buildTranslate(context, 'showingResultFor'),
                                  style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor),
                                ),
                                TextSpan(
                                  text: " +52 999-999-999",
                                  style: Fonts.textStyleSemiBold.copyWith(color: AppColor.appWhiteColor),
                                ),
                              ])),
                              CommonWidget.getFieldSpacer(height: 18),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return rechargeItem(index);
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return CommonWidget.getFieldSpacer(height: 20);
                                  },
                                ),
                              )
                            ],
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

  Widget rechargeItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            NavigatorHelper().add(CardDetailScreen(cardName: "AT&T"));
          },
          child: Column(
            children: [
              if (index == 0)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.appColorYellow,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )),
                    child: Text(
                      "  ${buildTranslate(context, "Recommended")}  ",
                      style: Fonts.textStyleSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: ShapeDecoration(
                  color: AppColor.appWhiteColor,
                  shape: SmoothRectangleBorder(
                      side: BorderSide(width: 0, color: AppColor.appBlackColor),
                      borderRadius: index == 0
                          ? const SmoothBorderRadius.only(
                              topRight: SmoothRadius.zero,
                              bottomRight: SmoothRadius(
                                cornerRadius: 12,
                                cornerSmoothing: 0.5,
                              ),
                              bottomLeft: SmoothRadius(
                                cornerRadius: 12,
                                cornerSmoothing: 0.5,
                              ),
                              topLeft: SmoothRadius(
                                cornerRadius: 12,
                                cornerSmoothing: 0.5,
                              ),
                            )
                          : const SmoothBorderRadius.all(
                              SmoothRadius(
                                cornerRadius: 12,
                                cornerSmoothing: 0.5,
                              ),
                            )),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$ 65.00",
                          style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
                        ),
                        CommonWidget.getFieldSpacer(height: 12),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AssetsHelper.getSVGIcon('ic_calendar.svg'),
                              height: 16,
                            ),
                            Text(
                              "  10 Days   ",
                              style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                            ),
                            SvgPicture.asset(
                              AssetsHelper.getSVGIcon('ic_candle.svg'),
                              height: 16,
                            ),
                            Text(
                              "  20 GB",
                              style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ButtonView(
                      width: 52,
                      height: 34,
                      buttonTextName: buildTranslate(context, 'buy').toUpperCase(),
                      style: TextStyle(color: AppColor.appWhiteColor),
                      color: AppColor.appPrimaryColor,
                      onPressed: () async {
                        NavigatorHelper().add(CardDetailScreen(cardName: "AT&T"));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
