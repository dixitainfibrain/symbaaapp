import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'CardDetailScreen.dart';
import 'ShopViewModel.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  ShopViewModel shopViewModel = ShopViewModel();

  @override
  void initState() {
    super.initState();
    shopViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => shopViewModel,
      child: Consumer<ShopViewModel>(
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
                  margin: const EdgeInsets.only(top: 62, left: 25, bottom: 20, right: 25), //62 22
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (shopViewModel.isSearch)
                        SizedBox(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width * 0.85,
                          child: TextFormField(
                            controller: shopViewModel.shopSearchController,
                            focusNode: shopViewModel.shopSearchFocus,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.search),
                              prefixIcon: InkWell(
                                onTap: () {
                                  shopViewModel.activeSearch();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon("ic_round_back.svg"),
                                    height: 14,
                                    width: 14,
                                  ),
                                ),
                              ),
                              hintText: buildTranslate(context, 'search'),
                              hintStyle: Fonts.textStyleRegular.copyWith(fontSize: 16),
                              contentPadding: const EdgeInsets.all(10),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: AppColor.appBlackColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: AppColor.appBlackColor, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                      if (!shopViewModel.isSearch) ...[
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: buildTranslate(context, 'shopFor'),
                              style: Fonts.textStyleRegular.copyWith(
                                color: AppColor.appBlackColor,
                                fontSize: 22,
                              ),
                            ),
                            WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                            TextSpan(
                              text: buildTranslate(context, 'eSim'),
                              style: Fonts.textStyleBold.copyWith(color: AppColor.appPrimaryLightColor, fontSize: 22),
                            ),
                          ]),
                        ),
                        IconButton(
                          onPressed: () {
                            shopViewModel.activeSearch();
                          },
                          icon: Icon(
                            Icons.search,
                            color: AppColor.appBlackColor,
                            size: 24,
                          ),
                        ),
                      ],
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
                    top: 120, //120 70
                    left: 20,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 40,
                              width: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColor.appWhiteColor,
                                border: Border.all(
                                  color: AppColor.grey,
                                ),
                              ),
                              child: SvgPicture.asset(
                                AssetsHelper.getSVGIcon('ic_filter.svg'),
                              ),
                            ),
                            if (shopViewModel.selectedFilterList.isNotEmpty)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColor.appRedColorError,
                                  ),
                                  child: Center(
                                    child: Text(
                                      shopViewModel.selectedFilterList.length.toString(),
                                      textAlign: TextAlign.center,
                                      style: Fonts.textStyleRegular.copyWith(fontSize: 12, color: AppColor.appWhiteColor),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        CommonWidget.getFieldSpacer(width: 18),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return selectFilter(index);
                            },
                            separatorBuilder: (context, index) {
                              return CommonWidget.getFieldSpacer(width: 5);
                            },
                            itemCount: shopViewModel.filterList.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 180, //180 120
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: InkWell(
                                  onTap: () {
                                    shopViewModel.feeTypeChange();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        shopViewModel.fee ? buildTranslate(context, 'inr') : buildTranslate(context, 'usd'),
                                        style: Fonts.textStyleRegular.copyWith(
                                          color: AppColor.appWhiteColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CommonWidget.getFieldSpacer(width: 10),
                                      SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(
                                          "ic_currency_change.svg",
                                        ),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: SingleChildScrollView(
                                  physics:const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      countryWiseShopData("Mexico", 4),
                                      CommonWidget.getFieldSpacer(height: 14),
                                      countryWiseShopData("USA", 3),
                                      CommonWidget.getFieldSpacer(height: 14),
                                      countryWiseShopData("Algeria", 3),
                                      CommonWidget.getFieldSpacer(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 10),
                              Container(
                                height: 120,
                                // color: AppColor.appBlackColor,
                                color: AppColor.appColorCommonContainer,
                                child: PageView.builder(
                                  controller: shopViewModel.pageController,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 110,
                                      width: MediaQuery.sizeOf(context).width,
                                      margin: const EdgeInsets.only(left: 20, right: 20),
                                      padding: const EdgeInsets.all(15),
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[AppColor.appPrimaryColor, AppColor.appPinInputBG],
                                        ),
                                        shape: const SmoothRectangleBorder(
                                            side: BorderSide(),
                                            borderRadius: SmoothBorderRadius.all(
                                              SmoothRadius(
                                                cornerRadius: 12,
                                                cornerSmoothing: 0.5,
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  2,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    height: 4,
                                    width: shopViewModel.currentPage == index ? 18 : 4,
                                    decoration: BoxDecoration(
                                      color: AppColor.appWhiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 10),
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

  Widget selectFilter(int index) {
    return InkWell(
      onTap: () {
        shopViewModel.addFilter(shopViewModel.filterList[index]);
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: shopViewModel.selectedFilterList.contains(shopViewModel.filterList[index]) ? AppColor.appPrimaryColor : AppColor.appWhiteColor,
          border: Border.all(
            color: shopViewModel.selectedFilterList.contains(shopViewModel.filterList[index]) ? Colors.transparent : AppColor.grey,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                shopViewModel.filterList[index],
                style: shopViewModel.selectedFilterList.contains(shopViewModel.filterList[index])
                    ? Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 16)
                    : Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
              ),
              if (shopViewModel.selectedFilterList.contains(shopViewModel.filterList[index]))
                Text(
                  "  x",
                  style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 20),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget countryWiseShopData(String countryName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsHelper.getSVGIcon(
                  "ic_dummy_flag.svg",
                ),
                height: 25,
                width: 25,
              ),
              CommonWidget.getFieldSpacer(width: 10),
              Expanded(
                child: Text(
                  countryName,
                  style: Fonts.textStyleBold.copyWith(fontSize: 18, color: AppColor.appWhiteColor),
                ),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 18),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 0.78,
            ),
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Visibility(
                    visible: index == 0,
                    replacement: const SizedBox(
                      height: 20,
                    ),
                    child: Align(
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
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailScreen(cardName: "AT&T")));
                    },
                    child: Container(
                      // margin: EdgeInsets.only(top: index == 1 ? 20 : 0),
                      decoration: ShapeDecoration(
                        color: AppColor.appWhiteColor,
                        shape: SmoothRectangleBorder(
                          side: BorderSide(width: 0, color: AppColor.appBlackColor),
                          borderRadius: index == 0
                              ? const SmoothBorderRadius.only(
                                  topRight: SmoothRadius.zero,
                                  bottomRight: SmoothRadius(cornerRadius: 12, cornerSmoothing: 0.5),
                                  bottomLeft: SmoothRadius(cornerRadius: 12, cornerSmoothing: 0.5),
                                  topLeft: SmoothRadius(
                                    cornerRadius: 12,
                                    cornerSmoothing: 0.5,
                                  ),
                                )
                              : const SmoothBorderRadius.all(
                                  SmoothRadius(cornerRadius: 12, cornerSmoothing: 0.5),
                                ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$ 65.00",
                                style: Fonts.textStyleBold.copyWith(fontSize: 17, color: AppColor.appBlackColor),
                              ),
                              ButtonView(
                                width: 52,
                                height: 34,
                                buttonTextName: buildTranslate(context, 'buy').toUpperCase(),
                                style: TextStyle(color: AppColor.appWhiteColor),
                                color: AppColor.appPrimaryColor,
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailScreen(cardName: "AT&T")));
                                },
                              ),
                            ],
                          ),
                          Text(
                            "AT&T",
                            style: Fonts.textStyleBold.copyWith(fontSize: 16, color: AppColor.textGray),
                          ),
                          CommonWidget.getFieldSpacer(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsHelper.getSVGIcon('ic_calendar.svg'),
                                height: 12,
                              ),
                              Text(
                                "  10 Days   ",
                                style: Fonts.textStyleSemiBold.copyWith(fontSize: 12, color: AppColor.appBlackColor),
                              ),
                              SvgPicture.asset(
                                AssetsHelper.getSVGIcon('ic_candle.svg'),
                                height: 12,
                              ),
                              Text(
                                "  20 GB",
                                style: Fonts.textStyleSemiBold.copyWith(fontSize: 12, color: AppColor.appBlackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
