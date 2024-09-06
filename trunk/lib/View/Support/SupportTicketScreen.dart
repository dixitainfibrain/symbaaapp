import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Support/GenerateSupportTicketScreen.dart';
import 'package:Symbaa/View/Support/SupportTicketChatScreen.dart';
import 'package:Symbaa/View/Support/SupportTicketViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../Helper/AssetsHelper.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  SupportTicketViewModel supportTicketViewModel = SupportTicketViewModel();

  @override
  void initState() {
    super.initState();
    supportTicketViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => supportTicketViewModel,
      child: Consumer<SupportTicketViewModel>(
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
                  margin: const EdgeInsets.only(top: 60, left: 25,right: 25),
                  width: 100,
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
                        onTap: (){
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
                children: [
                  CommonWidget.getFieldSpacer(height: 110),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: supportTicketViewModel.ticketList.length,
                      padding: EdgeInsets.zero,
                      physics:const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ticketCard(supportTicketViewModel.ticketList[index]);
                      },
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ticketCard(dynamic index) {
    return InkWell(
      onTap: (){
        NavigatorHelper().add(const SupportTicketChatScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              index['ticketName'],
              style: Fonts.textExtraBold.copyWith(
                color: AppColor.appColorCommonContainer,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            CommonWidget.getFieldSpacer(height: 5),
            Text(
              index['ticketDescription'],
              maxLines: 1,
              style: Fonts.textStyleRegular.copyWith(
                color: AppColor.appColorCommonContainer,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            CommonWidget.getFieldSpacer(height: 5),
            Row(
              children: [
                Text(
                  "${buildTranslate(context, 'CreatedOn')} ${index['ticketDate']}",
                  style: Fonts.textStyleRegular.copyWith(
                    color: AppColor.appColorCommonContainer,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.circle_sharp,
                  size: 8,
                  color: index['ticketStatus'] == "New"
                      ? AppColor.appColorStatusNew
                      : (index['ticketStatus'] == "InProgress" || index['ticketStatus'] == "Fixed")
                          ? AppColor.appColorStatusInProgress
                          : index['ticketStatus'] == "Completed"
                              ? AppColor.appPrimaryColor
                              : index['ticketStatus'] == "Re-Open"
                                  ? AppColor.appColorStatusReOpen
                                  : AppColor.appColorStatusRefund,
                ),
                CommonWidget.getFieldSpacer(width: 5),
                Text(
                  buildTranslate(context, '${index['ticketStatus']}'),
                  style: Fonts.textStyleRegular.copyWith(
                    color: AppColor.appColorCommonContainer,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
