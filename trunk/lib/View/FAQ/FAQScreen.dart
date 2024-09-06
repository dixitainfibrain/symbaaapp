import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/FAQ/FAQViewModel.dart';
import 'package:Symbaa/View/ProfileScreen/ProdileViewModel.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with SingleTickerProviderStateMixin {
  FAQViewModel faqViewModel = FAQViewModel();

  @override
  void initState() {
    super.initState();
    faqViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => faqViewModel,
      child: Consumer<FAQViewModel>(
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
                          buildTranslate(context, 'frequentlyAskedQuestions'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: commonBackGround(
                context,Stack(
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
                              margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 0),
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: faqViewModel.listFAQItem.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColor.appTextCardBG,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  faqViewModel.listFAQItem[index].title ?? '',
                                                  style: const TextStyle(fontSize: 15.5, color: Colors.white),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  faqViewModel.toggleExpansion(index);
                                                },
                                                child: Icon(
                                                  (faqViewModel.listFAQItem[index].isExpanded ?? false) ? Icons.remove : Icons.add,
                                                  color: AppColor.appColorYellow,
                                                  size: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: (faqViewModel.listFAQItem[index].isExpanded ?? false),
                                            child: Container(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text(
                                                faqViewModel.listFAQItem[index].description ?? '',
                                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return CommonWidget.getFieldSpacer(height: 25);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
