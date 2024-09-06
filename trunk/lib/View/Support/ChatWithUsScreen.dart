import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Support/ChatWithUsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatWithUsScreen extends StatefulWidget {
  const ChatWithUsScreen({super.key});

  @override
  State<ChatWithUsScreen> createState() => _ChatWithUsScreenState();
}

class _ChatWithUsScreenState extends State<ChatWithUsScreen> with SingleTickerProviderStateMixin {
  ChatWithUsViewModel chatWithUsViewModel = ChatWithUsViewModel();

  @override
  void initState() {
    super.initState();
    chatWithUsViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          toolbarHeight: 70,
          backgroundColor: AppColor.appTextFieldBG,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    NavigatorHelper.remove();
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: AppColor.appWhiteColor,
                    size: 22,
                  )),
              CommonWidget.getFieldSpacer(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                  child: AssetsHelper.getAssetImage(name: 'img_app_loading.png', fit: BoxFit.cover, height: 40.0, width: 40.0)),
              CommonWidget.getFieldSpacer(width: 10),
              Text(
                "Hello",
                style: Fonts.textStyleSemiBold.copyWith(fontSize: 18, color: AppColor.appWhiteColor, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: commonBackGround(context, const Stack()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 72,
          color: AppColor.appDividerColor,
          padding:const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: chatWithUsViewModel.messageController,
                  focusNode: chatWithUsViewModel.messageFocus,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColor.appBlackColor,
                  decoration: InputDecoration(
                    hintText: buildTranslate(context, 'enterQuestion'),
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
              CommonWidget.getFieldSpacer(width: 10),
              uploadButton(Icons.attach_file_rounded),
              CommonWidget.getFieldSpacer(width: 10),
              uploadButton(Icons.camera_alt_rounded)
            ],
          ),
        ));
  }

  Widget uploadButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.appBlackColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(
        icon,
        color: AppColor.appWhiteColor,
      ),
    );
  }
}
