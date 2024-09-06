import 'dart:developer';

import 'package:Symbaa/Style/AppTheme.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';

class ImagePickerBottomSheet extends StatefulWidget {
  final Function? callBackImages;

  const ImagePickerBottomSheet({Key? key, this.callBackImages}) : super(key: key);

  @override
  State<ImagePickerBottomSheet> createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  Future<void> pickImage(int index) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: index == 1 ? ImageSource.gallery : ImageSource.camera);
      log("picked file = ${pickedFile!.path.toString()}");
      if (pickedFile.path.isNotEmpty) {
        widget.callBackImages!(pickedFile);
      }
    } on PlatformException catch (e) {
      log("Exception = ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: AppColor.appWhiteColor,
        shape: SmoothRectangleBorder(
            side: BorderSide(width: 1, color: AppColor.appCurveBorderColor),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidget.getFieldSpacer(height: 20),
          Text(buildTranslate(context, 'uploadImage'), style: Fonts.textExtraBold.copyWith(color: AppColor.appPrimaryColor, fontSize: 18),),
          CommonWidget.getFieldSpacer(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //TODO : GALLERY
              ElevatedButton.icon(
                onPressed: () {
                  pickImage(1);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.appPrimaryColor),
                  elevation: MaterialStateProperty.all(0.0),
                ),
                icon: Icon(Icons.photo_camera_back, size: 25.0, color: AppColor.appWhiteColor),
                label: Text(buildTranslate(context, "galleryPick"), style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor)),
              ),
              //TODO : CAMERA
              ElevatedButton.icon(
                onPressed: () {
                  pickImage(0);
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.appPrimaryColor), elevation: MaterialStateProperty.all(0.0)),
                icon: Icon(Icons.camera_alt_rounded, size: 25.0, color: AppColor.appWhiteColor),
                label: Text(buildTranslate(context, "camera"), style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor)),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 30)
        ],
      ),
    );
  }
}
