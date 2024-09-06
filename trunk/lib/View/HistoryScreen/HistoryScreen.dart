import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/HistoryScreen/OrderHistoryDetailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/NavigatorHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../Custom/CustomAppBar.dart';
import '../Custom/DashedLinePainter.dart';
import '../RechargeScreen/RechargePlanScreen.dart';
import '../ShopScreen/OrderSummaryScreen.dart';
import 'HistoryViewModel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  HistoryViewModel historyViewModel = HistoryViewModel();

  @override
  void initState() {
    super.initState();
    historyViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => historyViewModel,
      child: Consumer<HistoryViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Container(
                  margin:  const EdgeInsets.only(top: 62, left: 25, bottom: 20),
                  child: Text(
                     buildTranslate(context, 'orderHistory'),
                    style: Fonts.textStyleBold.copyWith( fontSize: 18),
                  ),
                ),
              ),
            ),
            body: commonBackGround(
              context, Stack(
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
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return planItem(index: index, isActivePlan: index == 0);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return CommonWidget.getFieldSpacer(height: 20);
                              },
                            )),
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

  Widget planItem({int index = 0, bool? isActivePlan = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "July 2024",
          style: Fonts.textStyleRegular.copyWith(fontSize: 17, color: AppColor.appWhiteColor),
        ),
        CommonWidget.getFieldSpacer(height: 15),
        Container(
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
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColor.appWhiteColor, width: 0.5),
                color: AppColor.appWhiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          (isActivePlan ?? false) ? "\$65.00" : "\$10.00",
                          style: Fonts.textStyleBold.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          AssetsHelper.getSVGIcon(
                            "ic_dummy_flag.svg",
                          ),
                          height: 25,
                          width: 25,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                      Text(
                        "Mexico",
                        style: Fonts.textStyleSemiBold.copyWith(fontSize: 14, color: AppColor.appPrimaryColor),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 15),
                  Text(
                    "${buildTranslate(context, 'purchased')} 07 Jul, 2024 09:51 PM",
                    style: Fonts.textStyleRegular.copyWith(fontSize: 14, color: AppColor.textGray),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  CustomPaint(
                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                    painter: DashedLinePainter(
                      dashWidth: 2.7,
                      dashSpace: 3.5,
                      color: Colors.grey,
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          buildTranslate(context, 'data'),
                          style: Fonts.textStyleRegular.copyWith(
                            fontSize: 14.5,
                            color: AppColor.textGray
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 6),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "72.75GB/",
                            style: Fonts.textStyleRegular.copyWith(color: AppColor.textGray, fontSize: 14.5),
                          ),
                          TextSpan(
                            text: "100GB",
                            style: Fonts.textStyleRegular.copyWith(color: AppColor.appBlackColor, fontSize: 14.5),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  CustomPaint(
                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                    painter: DashedLinePainter(
                      dashWidth: 2.7,
                      dashSpace: 3.5,
                      color: Colors.grey,
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          buildTranslate(context, 'paymentMode'),
                          style: Fonts.textStyleRegular.copyWith(
                            fontSize:14.5,
                              color: AppColor.textGray
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 6),
                      Text(
                        "UPI",
                        style: Fonts.textStyleRegular.copyWith(
                          fontSize:14.5,
                        ),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          buildTranslate(context, 'redNumber'),
                          style: Fonts.textStyleRegular.copyWith(
                            fontSize:14.5,
                              color: AppColor.textGray
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 6),
                      Text(
                       "PR000XJMOVZ",
                        style: Fonts.textStyleRegular.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          buildTranslate(context, 'referralDiscount'),
                          style: Fonts.textStyleRegular.copyWith(
                            fontSize: 14.5,
                              color: AppColor.textGray
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 6),
                      Text(
                        "\$6.5",
                        style: Fonts.textStyleRegular.copyWith(
                          fontSize: 14.4,
                        ),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ButtonView(
                          borderColor: AppColor.appPrimaryColor,
                          textColor: AppColor.appPrimaryColor,
                          borderWidth: 1.1,
                          color: AppColor.appWhiteColor,
                          buttonTextName: buildTranslate(context, 'viewDetails').toUpperCase(),
                          style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appPrimaryColor),
                          onPressed: () async {
                            NavigatorHelper().add(const OrderHistoryDetailScreen());
                          },
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 20),
                      Flexible(
                        child: ButtonView(
                          borderColor: AppColor.appPrimaryColor,
                          textColor: AppColor.appWhiteColor,
                          color: AppColor.appPrimaryColor,
                          style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appWhiteColor),
                          buttonTextName: buildTranslate(context,index == 0 ? 'recharge' : 'topUp').toUpperCase(),
                          onPressed: () async {
                            if (index == 0) {
                              NavigatorHelper().add(const RechargePlanScreen());
                            } else {
                              NavigatorHelper().add(const OrderSummaryScreen());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
