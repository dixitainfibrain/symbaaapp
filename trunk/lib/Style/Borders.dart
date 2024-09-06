import 'package:flutter/material.dart';
import 'AppTheme.dart';

class Borders {
  static OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appDividerColor.withOpacity(0.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder focusBlueBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appDividerColor.withOpacity(0.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appSecondaryColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static UnderlineInputBorder focusBorder2 = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColor.appPrimaryColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appSecondaryColor, width: 0.4),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static UnderlineInputBorder enableBorder2 = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColor.appWhiteColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );

  static OutlineInputBorder disableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appUnFocusBorderColor, width: 0),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appRedColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static UnderlineInputBorder errorBorder2 = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColor.appRedColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );

  static OutlineInputBorder transparentBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appBackgroundColor),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static UnderlineInputBorder borderWhite = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));

  static UnderlineInputBorder borderGrey = UnderlineInputBorder(borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder focusGrey = UnderlineInputBorder(borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder enableGrey = UnderlineInputBorder(borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder disableGrey = UnderlineInputBorder(borderSide: BorderSide(color: AppColor.appDividerColor));

  static OutlineInputBorder searchFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
  static OutlineInputBorder searchFieldBorder2 = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0.4),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );


}
