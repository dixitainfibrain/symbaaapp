import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/HistoryScreen/OrderHistoryDetailScreen.dart';
import 'package:Symbaa/View/ShopScreen/CardDetailScreen.dart';
import 'package:Symbaa/View/ShopScreen/OrderSummaryScreen.dart';
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
import 'HomeViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    homeViewModel.init(context);
  }

  @override
  void dispose() {
    homeViewModel.pageController.dispose();
    homeViewModel.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(top: 40, left: 25, bottom: 20),
                  child: Row(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(55)),
                          child: CachedNetworkImage(
                            imageUrl: "",
                            fit: BoxFit.cover,
                            height: 55,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                )),
                              );
                            },
                            placeholder: (context, url) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.appSecondaryColor,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return AssetsHelper.getAssetImage(
                                name: "img_default_profile.png",
                                width: 55.0,
                                height: 55.0,
                              );
                            },
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello John",
                            style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 17),
                          ),
                          CommonWidget.getFieldSpacer(height: 5),
                          Text(
                            "Good Morning",
                            style: Fonts.textStyleRegular.copyWith(color: AppColor.grey, fontSize: 13.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body:commonBackGround(
              context,Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: ShapeDecoration(
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
                          physics:const BouncingScrollPhysics(),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1.16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.5,
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: buildTranslate(context, "referFriendMsg1"),
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 14),
                                              ),
                                              WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                              TextSpan(
                                                text: "10%",
                                                style: Fonts.textStyleBold.copyWith(color: AppColor.appColorYellow, fontSize: 14),
                                              ),
                                              WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                              TextSpan(
                                                text: buildTranslate(context, 'referFriendMsg2'),
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 14),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.3,
                                        child: AssetsHelper.getAssetImage(
                                          name: 'img_refer_friend.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(height: 25),
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
                                  margin: const EdgeInsets.only(left: 20, right: 20),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                                              SvgPicture.asset(
                                                AssetsHelper.getSVGIcon(
                                                  "ic_mobile.svg",
                                                ),
                                                height: 22,
                                              ),
                                              CommonWidget.getFieldSpacer(width: 10),
                                              Expanded(
                                                child: Text(
                                                  "+52 999-999-999",
                                                  style: Fonts.textStyleSemiBold
                                                      .copyWith(fontSize: 17, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: ()=>NavigatorHelper().add(const OrderHistoryDetailScreen()),
                                                child: SvgPicture.asset(
                                                  AssetsHelper.getSVGIcon("ic_forward.svg"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          CommonWidget.getFieldSpacer(height: 23),
                                          SizedBox(
                                            height: 75,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "10.19 GB",
                                                        style: Fonts.textStyleSemiBold
                                                            .copyWith(fontSize: 17, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
                                                      ),
                                                      CommonWidget.getFieldSpacer(height: 8),
                                                      Text(
                                                        "${buildTranslate(context, 'leftOf_')} ${20}GB",
                                                        style: Fonts.textStyleRegular.copyWith(fontSize: 13, color: AppColor.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                VerticalDivider(
                                                  color: AppColor.grey.withOpacity(0.4),
                                                  thickness: 1.5,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.only(left: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          buildTranslate(context, 'plan'),
                                                          style: Fonts.textStyleRegular.copyWith(fontSize: 13, color: AppColor.appBlackColor),
                                                        ),

                                                        Text(
                                                          "\$65",
                                                          style: Fonts.textStyleSemiBold
                                                              .copyWith(fontSize: 17, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
                                                        ),
                                                        Text(
                                                          "5 ${buildTranslate(context, 'daysLeft')}",
                                                          style: Fonts.textStyleRegular.copyWith(fontSize: 13, color: AppColor.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CommonWidget.getFieldSpacer(height: 23),
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
                                                  buttonTextName: buildTranslate(context, 'topUp').toUpperCase(),
                                                  onPressed: () async {
                                                    NavigatorHelper().add(const OrderSummaryScreen());
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(height: 20),
                                Container(
                                  margin: const EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    buildTranslate(context, 'myESim'),
                                    style: Fonts.textStyleRegular.copyWith(fontSize: 18, color: AppColor.appWhiteColor, fontWeight: FontWeight.w900),
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(height: 10),
                                SizedBox(
                                  height: 190,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return eSimListItem(index);
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return CommonWidget.getFieldSpacer(width: 10);
                                    },
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(height: 25),
                                SizedBox(
                                  height: 120,
                                  child: PageView.builder(
                                    controller: homeViewModel.pageController,
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
                                CommonWidget.getFieldSpacer(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    2,
                                        (index) => AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.symmetric(horizontal: 2),
                                      height: 4,
                                      width: homeViewModel.currentPage == index ? 18 : 4,
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget eSimListItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: index == 4 ? 20 : 0),
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailScreen(cardName: "AT&T")));
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.4,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColor.appWhiteColor, width: 0.5),
            color: AppColor.appWhiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.getFieldSpacer(height: 10),
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
                      "USA",
                      style: Fonts.textStyleRegular.copyWith(fontSize: 15, color: AppColor.appPrimaryColor),
                    ),
                  ),
                ],
              ),
              CommonWidget.getFieldSpacer(height: 10),
              Text(
                "+52 999-999-999",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 15, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
              ),
              CommonWidget.getFieldSpacer(height: 18),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "72.75GB/",
                    style: Fonts.textStyleRegular.copyWith(color: AppColor.textGray, fontSize: 14),
                  ),
                  TextSpan(
                    text: "100GB",
                    style: Fonts.textStyleRegular.copyWith(color: AppColor.appBlackColor, fontSize: 14),
                  ),
                ]),
              ),
              CommonWidget.getFieldSpacer(height: 23),
              Flexible(
                child: ButtonView(
                  borderColor: AppColor.appPrimaryColor,
                  textColor: AppColor.appWhiteColor,
                  color: AppColor.appPrimaryColor,
                  style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appWhiteColor),
                  buttonTextName: buildTranslate(context, 'topUp').toUpperCase(),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const OrderSummaryScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}