import 'package:Symbaa/Utils/Constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/AppGlobal.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();

  final Widget? child;

  BaseScreen({Key? key, this.child}) : super(key: key);
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Container(
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _checkInternet();

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.isNotEmpty && result[0] == ConnectivityResult.mobile) {
        isInternetAvailable.value = true;
      } else if (result.isNotEmpty && result[0] == ConnectivityResult.wifi) {
        isInternetAvailable.value = true;
      } else {
        isInternetAvailable.value = false;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    AppGlobal.printLog("LifeCycle ==> state $state");
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {
      AppGlobal.printLog("LifeCycle ==> Screen Paused");
    } else if (state == AppLifecycleState.detached) {
      AppGlobal.printLog("LifeCycle ==> Screen Detached");
    } else if (state == AppLifecycleState.inactive) {
      AppGlobal.printLog("LifeCycle ==> Screen Inactive");
    }
  }

  _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    AppGlobal.printLog("===================pre check global internet status is ${isInternetAvailable.value}=========================");

    if (connectivityResult == ConnectivityResult.mobile) {
      isInternetAvailable.value = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isInternetAvailable.value = true;
    } else {
      isInternetAvailable.value = false;
    }

    AppGlobal.printLog("===================global internet status is ${isInternetAvailable.value}=========================");
  }
}
