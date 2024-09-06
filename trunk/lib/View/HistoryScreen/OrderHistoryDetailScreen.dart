import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/DashedLinePainter.dart';
import 'package:Symbaa/View/HistoryScreen/OrderHistoryDetailViewModel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  const OrderHistoryDetailScreen({super.key});

  @override
  State<OrderHistoryDetailScreen> createState() => _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> with SingleTickerProviderStateMixin {
  OrderHistoryDetailViewModel orderHistoryDetailViewModel = OrderHistoryDetailViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => orderHistoryDetailViewModel,
      child: Consumer<OrderHistoryDetailViewModel>(
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
                        buildTranslate(context, 'orderDetail'),
                        style: Fonts.textStyleBold.copyWith(fontSize: 16),
                      ),
                    ],
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
                         padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: ShapeDecoration(
                          color: AppColor.appColorCommonContainer,
                          // color: AppColor.appBlackColor,
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
                        child: SingleChildScrollView(
                          physics:const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardAndCountry(),
                                orderDetail(item: "Amount", value: "\$65.00", color: AppColor.appColorYellow, fontSize: 22),
                                orderDetail(item:"Referral Discount",value: "\$6.5"),
                                orderDetail(item:"Paid Discount",value: "\$58.5"),
                                orderDetail(item:"Purchased on",value: "01 Jul, 2024 09:50 PM"),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: CustomPaint(
                                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                                    painter: DashedLinePainter(
                                      dashWidth: 2.7,
                                      dashSpace: 3.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                orderDetail(item:"Mobile No.",value: "+52 999-999-999"),
                                orderDetail(item:"Country",value: "Mexico"),
                                orderDetail(item:"Operator",value: "AT&T"),
                                orderDetail(item:"Plan",value: "Mobile Top-up"),
                                orderDetail(item:"Call",value: "Unlimited Calls to all Network"),
                                orderDetail(item:"SMS",value: "100 SMS/Day"),
                                orderDetail(item:"Data",value: "20 GB"),
                                orderDetail(item:"Validity",value: "7 Days"),
                                CommonWidget.getFieldSpacer(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Text(
                                    buildTranslate(context, 'planDescription'),
                                    style: Fonts.textStyleSemiBold.copyWith(fontSize: 18, color: AppColor.appWhiteColor),
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                    style: Fonts.textStyleRegular.copyWith(fontSize: 14, color: AppColor.appWhiteColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 18,right: 18),
                                  child: CustomPaint(
                                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                                    painter: DashedLinePainter(
                                      dashWidth: 2.7,
                                      dashSpace: 3.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                orderDetail(item:"Payment Mode",value: "Credit Card"),
                                orderDetail(item:"Ref. Number",value: "PR000XJM0VZ"),
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

  Widget orderDetail({Color? color, double? fontSize, String? item, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item ?? "",
            style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appWhiteColor.withOpacity(0.4)),
          ),
          Text(
            value ?? "",
            style: Fonts.textStyleSemiBold.copyWith(fontSize: fontSize ?? 18, color: color ?? AppColor.appWhiteColor),
          ),
        ],
      ),
    );
  }

  Widget cardAndCountry() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 0),
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
      child: Row(
        children: [
          SvgPicture.asset(
            AssetsHelper.getSVGIcon(
              "ic_dummy_flag.svg",
            ),
            height: 25,
            width: 25,
          ),
          CommonWidget.getFieldSpacer(width: 10),
          Text(
            "AT&T",
            style: Fonts.textStyleBold.copyWith(fontSize: 16),
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
    );
  }
}
