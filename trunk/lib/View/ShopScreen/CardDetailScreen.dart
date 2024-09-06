import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/DashedLinePainter.dart';
import 'package:Symbaa/View/ShopScreen/OrderSummaryScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'CardDetailViewModel.dart';

class CardDetailScreen extends StatefulWidget {
  String? cardName;

  CardDetailScreen({super.key, this.cardName});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> with SingleTickerProviderStateMixin {
  CardDetailViewModel cardDetailViewModel = CardDetailViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => cardDetailViewModel,
      child: Consumer<CardDetailViewModel>(
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
                        widget.cardName.toString(),
                        style: Fonts.textStyleRegular.copyWith(fontSize: 16),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              decoration: ShapeDecoration(
                                color: AppColor.appWhiteColor,
                                shape: SmoothRectangleBorder(
                                  side: BorderSide(width: 1, color: AppColor.appBlackColor),
                                  borderRadius: const SmoothBorderRadius.all(
                                    SmoothRadius(
                                      cornerRadius: 12,
                                      cornerSmoothing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$ 65.00",
                                        style: Fonts.textStyleBold.copyWith(fontSize: 22, color: AppColor.appBlackColor),
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(
                                          "ic_dummy_flag.svg",
                                        ),
                                        height: 25,
                                        width: 25,
                                      ),
                                      CommonWidget.getFieldSpacer(width: 10),
                                      Text(
                                        "Mexico",
                                        style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appPrimaryColor),
                                      ),
                                    ],
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  CustomPaint(
                                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                                    painter: DashedLinePainter(
                                      dashWidth: 2.7,
                                      dashSpace: 3.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 10),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_phone.svg'),
                                        height: 14,
                                      ),
                                      Text(
                                        "  Calls",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Unlimited Calls to all Network",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                    ],
                                  ),
                                  CommonWidget.getFieldSpacer(height: 12),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_message.svg'),
                                        height: 14,
                                      ),
                                      Text(
                                        "  SMS",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "100 SMS/Day",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                    ],
                                  ),
                                  CommonWidget.getFieldSpacer(height: 12),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_candle.svg'),
                                        height: 14,
                                      ),
                                      Text(
                                        "  Data",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "20 GB",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                    ],
                                  ),
                                  CommonWidget.getFieldSpacer(height: 12),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_calendar.svg'),
                                        height: 14,
                                      ),
                                      Text(
                                        "  Validity",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "7 Days",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CommonWidget.getFieldSpacer(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_note.svg'),
                                    height: 12,
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(width: 10),
                                Expanded(
                                  child: Text(
                                    "Post daily SMS quota charges applicable at \$0.12 for Local/STD SMS.",
                                    maxLines: 2,
                                    style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appWhiteColor),
                                  ),
                                ),
                              ],
                            ),
                            CommonWidget.getFieldSpacer(height: 30),
                            Text(
                              buildTranslate(context, 'Term&Condition'),
                              style: TextStyle(
                                color: AppColor.appColorYellow,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor: AppColor.appColorYellow,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: ButtonView(
              buttonTextName: buildTranslate(context, 'proceedToPay').toUpperCase(),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderSummaryScreen()));
              },
            ),
          );
        },
      ),
    );
  }
}
