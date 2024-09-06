import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/Custom/DashedLinePainter.dart';
import 'package:Symbaa/View/ShopScreen/OrderSummaryViewModel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> with SingleTickerProviderStateMixin {
  OrderSummaryViewModel orderSummaryViewModel = OrderSummaryViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => orderSummaryViewModel,
      child: Consumer<OrderSummaryViewModel>(
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
                        buildTranslate(context, 'orderSummary'),
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
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              planCard(),
                              promoCodeCard(),
                              CommonWidget.getFieldSpacer(height: 20),
                              Center(
                                child: ButtonView(
                                  buttonTextName: buildTranslate(context, 'makePayment').toUpperCase(),
                                  onPressed: () async {
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderSummaryScreen()));
                                  },
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 20),
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

  Widget planCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          CommonWidget.getFieldSpacer(height: 12),
          CustomPaint(
            size: const Size(double.infinity, 0.5), // Width of the dashed line
            painter: DashedLinePainter(
              dashWidth: 2.7,
              dashSpace: 3.5,
              color: Colors.grey,
            ),
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mobile No.",
                style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
              Text(
                "+52 999-999-999",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Country",
                style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
              Text(
                "Mexico",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Operator",
                style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
              Text(
                "At&T",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Plan",
                style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
              Text(
                "Mobile Top-up",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Validity",
                style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
              Text(
                "7 Days",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 12),
          Text(
            buildTranslate(context, 'planDescription'),
            style: Fonts.textStyleSemiBold.copyWith(fontSize: 18, color: AppColor.appBlackColor),
          ),
          CommonWidget.getFieldSpacer(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: Fonts.textStyleRegular.copyWith(fontSize: 14, color: AppColor.appBlackColor),
          )
        ],
      ),
    );
  }

  Widget promoCodeCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            buildTranslate(context, 'promoCode'),
            style: Fonts.textStyleSemiBold.copyWith(fontSize: 18, color: AppColor.appBlackColor),
          ),
          CommonWidget.getFieldSpacer(height: 20),
          CustomTextField(
            textInputType: TextInputType.text,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColor.appSecondaryColor)),
            hintStyle: TextStyle(color: AppColor.appBlackColor),
            tecController: orderSummaryViewModel.promoCodeTextController,
            focusNode: orderSummaryViewModel.promoCodeFocus,
            fillColor: AppColor.appWhiteColor,
            isShowSuffixIcon: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                buildTranslate(context, 'apply'),
                style: Fonts.textStyleBold.copyWith(color: AppColor.appPrimaryColor, fontSize: 16),
              ),
            ),
            hintText: buildTranslate(context, 'enterPromoCode'),
            labelText: "",
          ),
          CommonWidget.getFieldSpacer(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: ShapeDecoration(
              color: AppColor.grey.withOpacity(0.4),
              shape: const SmoothRectangleBorder(
                side: BorderSide(width: 1, color: Colors.transparent),
                borderRadius: SmoothBorderRadius.all(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buildTranslate(context, 'amount'),
                      style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                    Text(
                      "\$65",
                      style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                  ],
                ),
                CommonWidget.getFieldSpacer(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${buildTranslate(context, 'referralDiscount')} (10%)",
                      style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                    Text(
                      "\$6.5",
                      style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                  ],
                ),
                CommonWidget.getFieldSpacer(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${buildTranslate(context, 'promoDiscount')} (5%)",
                      style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                    Text(
                      "\$3.25",
                      style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appBlackColor),
                    ),
                  ],
                ),
                CommonWidget.getFieldSpacer(height: 12),
                Container(
                  height: 2,
                  color: AppColor.grey,
                ),
                CommonWidget.getFieldSpacer(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buildTranslate(context, 'payableAmount'),
                      style: Fonts.textStyleRegular.copyWith(fontSize: 16, color: AppColor.appPrimaryColor),
                    ),
                    Text(
                      "\$55.25",
                      style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appPrimaryColor),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
