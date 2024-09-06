import 'dart:developer';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:flutter/material.dart';
import '../Utils/Constants.dart';
import 'AppLocalization.dart';

String buildTranslate(BuildContext context, String key) => AppLocalization.of(context)?.translate(key) ?? '';

Future<Locale> setLocale(String languageCode) async {
  await SharedPref.savePreferenceValue(prefKeyLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await SharedPref.readPreferenceValue(prefKeyLanguageCode, PrefEnum.STRING);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'US');
    default:
      return const Locale('en', 'US');
  }
}

Future<Locale> changeLanguage(String selectedLanguageCode) async {
  var locale = await setLocale(selectedLanguageCode);
  return locale;
}
