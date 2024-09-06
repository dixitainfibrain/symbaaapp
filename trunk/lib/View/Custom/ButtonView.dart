import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import '../../helper/AssetsHelper.dart';

class ButtonView extends StatelessWidget {
  ButtonView(
      {Key? key,
      this.buttonTextName,
      this.onPressed,
      this.width,
      this.margin,
      this.color,
      this.height,
      this.style,
      this.borderRadius,
      this.borderColor,
      this.progressColor,
      this.textColor,
      this.borderWidth,
      this.vnIsShowLoader,
      this.showSuffixIcon = false,
      this.showPrefixIcon = false,
      this.prefixIcon})
      : super(key: key);

  final String? buttonTextName;
  final Function? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? style;
  final double? margin;
  final Color? color;
  final Color? borderColor;
  final Color? progressColor;
  final Color? textColor;
  final double? borderWidth;
  final String? prefixIcon;
  bool? showSuffixIcon = false;
  bool? showPrefixIcon = false;
  ValueNotifier<bool>? vnIsShowLoader = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (vnIsShowLoader != null) {
          if (!vnIsShowLoader!.value) onPressed!();
        } else {
          onPressed!();
        }
      },
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.88,
        height: height ?? 45,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(color: borderColor ?? AppColor.appCurveBorderColor, width: borderWidth ?? 0.5),
          color: color ?? AppColor.appWhiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: showPrefixIcon!,
              child: showPrefixIcon! && (vnIsShowLoader?.value == false)
                  ? Row(
                      children: [
                        SvgPicture.asset(
                          AssetsHelper.getSVGIcon(prefixIcon!),
                          height: 25,
                          color: AppColor.appWhiteColor,
                        ),
                        CommonWidget.getFieldSpacer(width: 10),
                      ],
                    )
                  : const SizedBox(),
            ),
            Center(
              child: (vnIsShowLoader != null)
                  ? ValueListenableBuilder(
                      valueListenable: vnIsShowLoader!,
                      builder: (context, val, child) => Visibility(
                        visible: vnIsShowLoader!.value,
                        replacement: Row(
                          children: [
                            Text(
                              buttonTextName!,
                              style: style ?? Fonts.textExtraBold.copyWith(fontSize: 18, color: textColor ?? AppColor.appPrimaryColor),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            CommonWidget.getFieldSpacer(width: 10),
                            Visibility(
                                visible: showSuffixIcon!,
                                child: SvgPicture.asset(
                                  AssetsHelper.getSVGIcon('ic_arrow_right.svg'),
                                )),
                          ],
                        ),
                        child: SizedBox(
                          width: height ?? 35,
                          height: height ?? 35,
                          child: CircularProgressIndicator(
                            strokeWidth: 4.0,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation(progressColor ?? AppColor.appPrimaryColor),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      buttonTextName!,
                      style: style ?? Fonts.textExtraBold.copyWith(fontSize: 18, color: textColor ?? AppColor.appPrimaryColor),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
