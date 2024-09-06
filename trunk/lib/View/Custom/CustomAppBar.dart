import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../Style/AppTheme.dart';
import '../../helper/AssetsHelper.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      required this.onBackPressed,
      this.onNotificationPressed,
      this.backButtonIcon,
      this.childrens,
      this.actions,
      this.count,
      this.appBarHeight,
      this.leadingWidth,
      this.titleSpacing,
      this.backButtonColor,
      this.backgroundColor,
      this.statusBarColor,
      this.leadingIconPadding,
      this.showBackIcon = true,
      this.showWhiteBackIcon = false,
      this.centerTitle = true,
      this.showNotificationIcon = false})
      : super(key: key);

  VoidCallback? onBackPressed, onNotificationPressed;
  String? backButtonIcon;
  final int? count;
  final double? appBarHeight, titleSpacing, leadingWidth;
  bool? showNotificationIcon = false;
  bool? showBackIcon = true;
  bool? showWhiteBackIcon = false;
  bool centerTitle = true;
  List<Widget>? childrens;
  List<Widget>? actions;
  Widget? backIcon;
  final Color? backButtonColor;
  final Color? backgroundColor;
  final Color? statusBarColor;
  EdgeInsetsGeometry? leadingIconPadding;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: widget.centerTitle,
      toolbarHeight: widget.appBarHeight ?? 80,
      elevation: 0,
      titleSpacing: widget.titleSpacing ?? 15,
      scrolledUnderElevation: 0.0,
      title: Column(
        crossAxisAlignment: widget.centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: widget.childrens!,
      ),
      leading: (widget.showBackIcon ?? false)
          ? GestureDetector(
              onTap: widget.onBackPressed,
              child: SizedBox(
                height: 6,
                width: 6,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.backIcon ??
                      SvgPicture.asset(
                        AssetsHelper.getSVGIcon("ic_white_back.svg"),
                        color: (widget.showWhiteBackIcon ?? false) ? AppColor.appWhiteColor  : widget.backButtonColor,
                        height: 6,
                        width: 6,
                      ),
                ),
              ),
            )
          : null,
      leadingWidth: widget.leadingWidth ?? 65,
      actions: widget.actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: widget.statusBarColor ?? AppColor.appWhiteColor,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    );
  }
}
