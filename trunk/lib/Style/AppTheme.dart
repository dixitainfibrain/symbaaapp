import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBG = const Color(0xFFFFFFFF);
  static String appSemiBoldFont = "AppSemiBold";

  static Map<int, Color> myColor = {
    50: const Color.fromRGBO(17, 112, 217, .1),
    100: const Color.fromRGBO(17, 112, 217, .2),
    200: const Color.fromRGBO(17, 112, 217, .3),
    300: const Color.fromRGBO(17, 112, 217, .4),
    400: const Color.fromRGBO(17, 112, 217, .5),
    500: const Color.fromRGBO(17, 112, 217, .6),
    600: const Color.fromRGBO(17, 112, 217, .7),
    700: const Color.fromRGBO(17, 112, 217, .8),
    800: const Color.fromRGBO(17, 112, 217, .9),
    900: const Color.fromRGBO(17, 112, 217, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF010432, myColor);

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.appPrimaryColor.withOpacity(.5),
      cursorColor: AppColor.appPrimaryColor.withOpacity(.6),
      selectionHandleColor: AppColor.appPrimaryColor.withOpacity(1),
    ),
    fontFamily: "AppRegular",
    primaryColor: colorCustom,
    focusColor: colorCustom,
    scaffoldBackgroundColor: lightBG,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom).copyWith(secondary: colorCustom).copyWith(background: Colors.white),
  );
}

class AppColor {
  static Color appPrimaryColor = const Color(0xFF0A47AA);
  static Color appPrimaryLightColor = const Color(0xFF1052BD);
  static Color appPrimaryDarkColor = const Color(0xFF0A47AA);
  static Color appSecondaryColor = const Color(0xFF679DF6);
  static Color appCurveBorderColor = const Color(0xFF417FE3);
  static Color appPinInputBG = const Color(0xFF1052BD);
  static Color appTextFieldBG = const Color(0xFF071D3E);
  static Color appTextCardBG = const Color(0xFF1d293e);
  static Color appThemeBG = const Color(0xFFEBF0F8);
  static Color appBlackColor = const Color(0xFF0C0C0C);
  static Color appWhiteColor = const Color(0xFFFFFFFF);
  static Color appBg = const Color(0xFFF8F8F8);
  static Color appDividerColor = const Color(0xFFD3D3D3);
  static Color appFocusBorderColor = const Color(0xFF0C0C0C);
  static Color appUnFocusBorderColor = const Color(0xFF0C0C0C);
  static Color appBackgroundColor = const Color(0xFF010020);
  static Color appRedColor = const Color(0xFFFF1010);
  static Color appRedColorLight = const Color(0xFFF34242);
  static Color appRedColorError = const Color(0xFFEA2017);
  static Color appTextFormField = const Color(0xFFFFFFFF);
  static Color appGrey = const Color(0xFF403F58);
  static Color grey = const Color(0xFF868585);
  static Color textGray = const Color(0xFF807E7E);
  static Color appColorYellow = const Color(0xFFF7DF35);

  static Color appColorGreen = const Color(0xFF81B823);
  static Color appColorGreenLight = const Color(0xFFA2E62E);
  static Color appColorPink = const Color(0xFFFF4565);
  static Color appColorCommonContainer = const Color(0xFF031127);

  static Color appColorStatusNew = const Color(0xFFA1A1A1);
  static Color appColorStatusInProgress = const Color(0xFF00B02E);
  static Color appColorStatusReOpen = const Color(0xFFEFDA38);
  static Color appColorStatusRefund = const Color(0xFF97DF7D);
}
