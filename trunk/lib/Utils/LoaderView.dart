import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/KeyboardHideView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderView extends StatelessWidget {

  Color? color;

  LoaderView({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: color ?? AppColor.appPrimaryColor,
      child: Center(
        child: KeyboardHideView(
          child: SpinKitDoubleBounce(
            color: AppColor.appPrimaryColor,
            size: 50.0,
          ),
        ),
      ),
    );

  }
}
