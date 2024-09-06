import 'dart:async';
import 'dart:io';

import 'package:Symbaa/Utils/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetChecker {
  StreamSubscription<List<ConnectivityResult>>? subscription;

  void startMonitoring(BuildContext context) {
    _checkInternet().then((isConnected) {
      isInternetAvailable.value = isConnected;
    });

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.isNotEmpty && result[0] == ConnectivityResult.none) {
        isInternetAvailable.value = false;
        // AlertHelper.showAppSnackBar(scaffoldMessengerKey.currentState!.context, message: 'No Internet');
      } else {
        _checkInternet().then((isConnected) {
          isInternetAvailable.value = isConnected;
        });
      }
    });
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
