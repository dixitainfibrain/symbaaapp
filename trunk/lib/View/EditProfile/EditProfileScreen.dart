import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/Regex.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/EditProfile/EditProdileViewModel.dart';
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin {
  EditProfileViewModel editProfileViewModel = EditProfileViewModel();

  @override
  void initState() {
    super.initState();
    editProfileViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => editProfileViewModel,
      child: Consumer<EditProfileViewModel>(
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
                          buildTranslate(context, 'editProfile'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
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
                    top: 180,
                    left: 0,
                    right: 0,
                    bottom: 0,
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
                        margin: const EdgeInsets.only(top: 65, left: 20, right: 20),
                        child: Form(
                          key: editProfileViewModel.formKeyEditProfile,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonWidget.getFieldSpacer(height: 30),
                                CustomTextField(
                                  fillColor: AppColor.appTextFieldBG,
                                  tecController: editProfileViewModel.firstNameController,
                                  focusNode: editProfileViewModel.fnFirstName,
                                  hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                  hintText: buildTranslate(context, 'hintFirstName'),
                                  labelText: "${buildTranslate(context, 'firstName')}*",
                                  validator: (value) {
                                    return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterFirstName');
                                  },
                                ),
                                CommonWidget.getFieldSpacer(height: 18),
                                CustomTextField(
                                  fillColor: AppColor.appTextFieldBG,
                                  hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                  tecController: editProfileViewModel.lastNameController,
                                  focusNode: editProfileViewModel.fnLastName,
                                  hintText: buildTranslate(context, 'hintLastName'),
                                  labelText: "${buildTranslate(context, 'lastName')}*",
                                  validator: (value) {
                                    return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterLastName');
                                  },
                                ),
                                CommonWidget.getFieldSpacer(height: 18),
                                CustomTextField(
                                  fillColor: AppColor.appTextFieldBG,
                                  hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                  tecController: editProfileViewModel.emailController,
                                  focusNode: editProfileViewModel.fnEmail,
                                  hintText: buildTranslate(context, 'hintEmail'),
                                  labelText: "${buildTranslate(context, 'email')}*",
                                  validator: (value) {
                                    return ValidationHelper.checkEmailValidation(context, value);
                                  },
                                ),
                                CommonWidget.getFieldSpacer(height: 18),
                                CustomTextField(
                                  fillColor: AppColor.appTextFieldBG,
                                  hintColor: AppColor.appWhiteColor.withOpacity(0.6),
                                  tecController: editProfileViewModel.mobileController,
                                  focusNode: editProfileViewModel.fnMobile,
                                  hintText: buildTranslate(context, 'enterPhone'),
                                  labelText: "${buildTranslate(context, 'phone')}*",
                                  inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(Regex.onlyDigits)],
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    return ValidationHelper.checkPhoneNoValidation(context, value);
                                  },
                                ),
                                CommonWidget.getFieldSpacer(height: 35),
                                ButtonView(
                                  buttonTextName: buildTranslate(context, 'save').toUpperCase(),
                                  onPressed: () async {
                                    // if (editProfileViewModel.formKeyEditProfile.currentState?.validate() ?? false) {}
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
                  Positioned(
                    top: 130,
                    left: 0,
                    right: 0,
                    child: Hero(
                      tag: heroProfileItem,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.appWhiteColor,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(103)),
                                child: (editProfileViewModel.fileName.isEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl: "",
                                        fit: BoxFit.cover,
                                        height: 103,
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
                                              color: AppColor.appBlackColor,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return AssetsHelper.getAssetImage(
                                            name: "img_default_profile.png",
                                            width: 103.0,
                                            height: 103.0,
                                          );
                                        },
                                      )
                                    : Image.file(
                                        editProfileViewModel.profileImage!,
                                        fit: BoxFit.cover,
                                        width: 103,
                                        height: 103,
                                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                          print("frame ======> $frame");
                                          return (frame == null)
                                              ? Center(
                                                  child: CircularProgressIndicator(
                                                    color: AppColor.appBlackColor,
                                                  ),
                                                )
                                              : child;
                                        },
                                      ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 207,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        editProfileViewModel.showImagePickerBottomSheet(context);
                      },
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: Container(
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.only(left: 75,bottom: 83,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.appPrimaryColor,
                          ),
                          padding: const EdgeInsets.all(6.5),
                          child: SvgPicture.asset(
                              AssetsHelper.getSVGIcon(
                                "ic_camera.svg",
                              ),
                              color: AppColor.appWhiteColor),
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
