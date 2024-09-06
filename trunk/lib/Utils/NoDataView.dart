import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  NoDataView({super.key, this.message});

  final String? message;
  dynamic height;
  dynamic width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height,
        child: Text(buildTranslate(context, 'noRecordFound'), style: Fonts.textStyleRegular.copyWith(fontSize: 15)),
      ),
    );
  }
}
