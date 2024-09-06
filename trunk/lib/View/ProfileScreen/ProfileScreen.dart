import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/ProfileScreen/ProdileViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import '../ChangePassword/ChangePasswordScreen.dart';
import '../EditProfile/EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  ProfileViewModel profileViewModel = ProfileViewModel();


  @override
  void initState() {
    super.initState();
    profileViewModel.init(context);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => profileViewModel,
      child: Consumer<ProfileViewModel>(
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
                          buildTranslate(context, 'profile'),
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
                          margin: const EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                "John Doe",
                                style: Fonts.textStyleBold.copyWith(fontSize: 20, color: AppColor.appWhiteColor),
                              ),
                              CommonWidget.getFieldSpacer(height: 10),
                              Text(
                                "johndoe1234@email.com",
                                style: Fonts.textStyleRegular.copyWith(fontSize: 15, color: AppColor.appColorYellow),
                              ),
                              CommonWidget.getFieldSpacer(height: 30),
                              ListView.separated(
                                padding: const EdgeInsets.only(top: 00),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: profileViewModel.listMenu.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return listItem(index);
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 1,
                                    color: AppColor.appWhiteColor.withOpacity(0.45),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 0,
                      right: 0,
                      child: Hero(
                        tag: heroProfile,
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
                                  child: CachedNetworkImage(
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
                                          color: AppColor.appSecondaryColor,
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfileScreen()));
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
                                  "ic_edit.svg",
                                ),
                                color: AppColor.appWhiteColor),
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

  Widget listItem(int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfileScreen()));
        } else if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
        } else if (index == 2) {
          profileViewModel.showDeleteAccountDialog();
        } else if (index == 3) {
          profileViewModel.showLogoutDialog();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.getFieldSpacer(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AssetsHelper.getSVGIcon(profileViewModel.listMenu[index].icon ?? ''), height: 22, color: AppColor.appWhiteColor),
              CommonWidget.getFieldSpacer(width: 10),
              Expanded(
                child: Text(
                  buildTranslate(context, profileViewModel.listMenu[index].name ?? ''),
                  style: Fonts.textStyleBold.copyWith(fontSize: 16, color: AppColor.appWhiteColor),
                ),
              ),
              Visibility(
                visible: index != 3,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                        AssetsHelper.getSVGIcon(
                          "ic_forward.svg",
                        ),
                        color: AppColor.appWhiteColor),
                  ),
                ),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 20),
        ],
      ),
    );
  }
}
