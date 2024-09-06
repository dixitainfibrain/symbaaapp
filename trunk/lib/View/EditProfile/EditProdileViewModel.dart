
import 'dart:io';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../Custom/ImagePickerBottomSheet.dart';


class EditProfileViewModel extends ChangeNotifier {
  late BuildContext context;
  final formKeyEditProfile = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  FocusNode fnFirstName = FocusNode();
  FocusNode fnLastName = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnMobile = FocusNode();

  File? profileImage;
  String fileName = '';

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImagePickerBottomSheet(
        callBackImages: (XFile file) {
          if (file.path.isNotEmpty) {
            final imageTemp = File(file.path);
            profileImage = imageTemp;
            fileName = basename(imageTemp.path);
            notifyListeners();
            NavigatorHelper.remove();
          }

        },
      ),
    );
  }


}
