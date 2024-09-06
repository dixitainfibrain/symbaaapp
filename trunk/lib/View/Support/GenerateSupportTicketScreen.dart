import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/Regex.dart';
import 'package:Symbaa/Helper/ValidationHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/Support/GenerateSupportTicketViewModel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';

class GenerateSupportTicketScreen extends StatefulWidget {
  const GenerateSupportTicketScreen({super.key});

  @override
  State<GenerateSupportTicketScreen> createState() => _GenerateSupportTicketScreenState();
}

class _GenerateSupportTicketScreenState extends State<GenerateSupportTicketScreen> {
  GenerateSupportTicketViewModel generateTicketViewModel = GenerateSupportTicketViewModel();

  @override
  void initState() {
    super.initState();
    generateTicketViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => generateTicketViewModel,
      child: Consumer<GenerateSupportTicketViewModel>(
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
                          buildTranslate(context, 'GenerateTitle'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                        ),
                      ],
                    ),
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
                            margin: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Form(
                                key: generateTicketViewModel.formKeyTicket,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      tecController: generateTicketViewModel.fullNameCtrl,
                                      focusNode: generateTicketViewModel.fullNameFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintFullName'),
                                      labelText: buildTranslate(context, 'FullName'),
                                      validator: (value) {
                                        return ValidationHelper.checkBlankValidation(context, value, 'FullNameError');
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    CustomTextField(
                                      tecController: generateTicketViewModel.emailCtrl,
                                      focusNode: generateTicketViewModel.emailFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintEmail'),
                                      labelText: buildTranslate(context, 'email'),
                                      validator: (value) {
                                        return ValidationHelper.checkEmailValidation(context, value);
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    CustomTextField(
                                      tecController: generateTicketViewModel.mobileNoCtrl,
                                      focusNode: generateTicketViewModel.mobileFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintMobileNumber'),
                                      labelText: buildTranslate(context, 'MobileNo'),
                                      inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(Regex.onlyDigits)],
                                      validator: (value) {
                                        return ValidationHelper.checkMobileNoValidation(context, value);
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    CustomTextField(
                                      tecController: generateTicketViewModel.iccidNoCtrl,
                                      focusNode: generateTicketViewModel.iccidFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintIccidNo'),
                                      labelText: buildTranslate(context, 'ICCIDNo'),
                                      validator: (value) {
                                        return ValidationHelper.checkBlankValidation(context, value, 'iccidError');
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    CustomTextField(
                                      tecController: generateTicketViewModel.subjectCtrl,
                                      focusNode: generateTicketViewModel.subjectFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintSubject'),
                                      labelText: buildTranslate(context, 'Subject'),
                                      validator: (value) {
                                        return ValidationHelper.checkBlankValidation(context, value, 'subjectError');
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    CustomTextField(
                                      maxLines: 4,
                                      minLines: 4,
                                      tecController: generateTicketViewModel.descriptionCtrl,
                                      focusNode: generateTicketViewModel.descriptionFocus,
                                      fillColor: AppColor.appTextFieldBG,
                                      hintText: buildTranslate(context, 'hintDescribeYourQuestionOrProblem'),
                                      labelText: buildTranslate(context, 'Description'),
                                      validator: (value) {
                                        return ValidationHelper.checkBlankValidation(context, value, 'PleaseEnterYourQueries');
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 18),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: AppColor.textGray,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AssetsHelper.getSVGIcon(
                                              'ic_upload.svg',
                                            ),
                                          ),
                                          CommonWidget.getFieldSpacer(height: 10),
                                          Text(
                                            buildTranslate(context, 'upload'),
                                            style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 18, fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(height: 28),
                                    ButtonView(
                                      buttonTextName: buildTranslate(context, 'save').toUpperCase(),
                                      onPressed: () async {
                                        if (generateTicketViewModel.formKeyTicket.currentState?.validate() ?? false) {}
                                      },
                                    ),
                                    CommonWidget.getFieldSpacer(height: 28),
                                  ],
                                ),
                              ),
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
}
