import 'dart:io';
import 'package:Symbaa/Helper/FirebaseHelper.dart';
import 'package:Symbaa/Localization/AppLocalization.dart';
import 'package:Symbaa/Network/InternetConnectionCheck.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/BaseScreen.dart';
import 'package:Symbaa/View/Splash/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Style/AppTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isIOS ? Firebase.initializeApp() : await Firebase.initializeApp(
    options: FirebaseHelper.firebaseOptions
  //    options: const FirebaseOptions(apiKey: 'AIzaSyAg9KldIM-UW3sOgyl7dZ2Nu1r9Q-8cLN4', appId: "com.symbaa.app", projectId: 'symbaa-4f8a9', messagingSenderId: '206996905275')
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InternetChecker().startMonitoring(context);
    return BaseScreen(
      child: MaterialApp(
        title: 'Symbaa',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: AppColor.appWhiteColor,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.appPrimaryColor),
          textSelectionTheme: TextSelectionThemeData(cursorColor: AppColor.appWhiteColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          AppLocalization.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode && supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
