import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/Regex.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/ApiState.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/commonLoader.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import '../Custom/CustomTextField.dart';
import 'ChangePasswordViewModel.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with SingleTickerProviderStateMixin {
  ChangePasswordViewModel changePasswordViewModel = ChangePasswordViewModel();

  @override
  void initState() {
    super.initState();
    changePasswordViewModel.init(context);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => changePasswordViewModel,
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
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
                              buildTranslate(context, 'changePassword'),
                              style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: commonBackGround(
                  context, Stack(
                    children: [
                      Positioned(
                        top: 106,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.appSecondaryColor.withOpacity(0.2),
                                offset: const Offset(0,1.0),
                                blurRadius: 60.0,
                                spreadRadius: 90,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: 250,
                            height: 200,
                            child: AssetsHelper.getAssetImage(name: 'img_change_pwd.png', fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 355,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Hero(
                          tag: heroProfileItem,
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
                                margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                                child: Form(
                                  key: changePasswordViewModel.formKeyChangePassword,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CommonWidget.getFieldSpacer(height: 30),
                                        CustomTextField(
                                          fillColor: AppColor.appTextFieldBG,
                                          tecController: changePasswordViewModel.currentPwdController,
                                          focusNode: changePasswordViewModel.fnCurrentPwd,
                                          hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                          hintText: buildTranslate(context, 'hintCurrentPassword'),
                                          labelText: "${buildTranslate(context, 'currentPassword')}*",
                                          validator: (value) {
                                            return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterCurrentPassword');
                                          },
                                        ),
                                        CommonWidget.getFieldSpacer(height: 18),
                                        CustomTextField(
                                          fillColor: AppColor.appTextFieldBG,
                                          hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                          tecController: changePasswordViewModel.newPwdController,
                                          focusNode: changePasswordViewModel.fnNewPwd,
                                          hintText: buildTranslate(context, 'hintNewPassword'),
                                          labelText: "${buildTranslate(context, 'newPassword')}*",
                                          validator: (value) {
                                            return ValidationHelper.checkPasswordValidation(context, value, 'pleaseEnterNewPassword');
                                          },
                                        ),
                                        CommonWidget.getFieldSpacer(height: 18),
                                        CustomTextField(
                                          fillColor: AppColor.appTextFieldBG,
                                          hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                          tecController: changePasswordViewModel.confirmPwdController,
                                          focusNode: changePasswordViewModel.fnConfirmPwd,
                                          hintText: buildTranslate(context, 'hintReEnterPassword'),
                                          labelText: "${buildTranslate(context, 'confirmPassword')}*",
                                          validator: (value) {
                                            return ValidationHelper.checkConfirmPasswordValidation(
                                                context, value, changePasswordViewModel.newPwdController.text);
                                          },
                                        ),
                                        CommonWidget.getFieldSpacer(height: 30),
                                        ButtonView(
                                          buttonTextName: buildTranslate(context, 'save').toUpperCase(),
                                          onPressed: () async {
                                             if (changePasswordViewModel.formKeyChangePassword.currentState?.validate() ?? false) {
                                               changePasswordViewModel.resetPassword();
                                             }
                                          },
                                        ),
                                        CommonWidget.getFieldSpacer(height: 18),
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
              ),

              if(changePasswordViewModel.userChangePassword.state == ApiState.LOADING) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
