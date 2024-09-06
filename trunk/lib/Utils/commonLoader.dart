import 'dart:ui';
import 'package:Symbaa/Helper/AssetsHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:flutter/material.dart';

Widget commonLoader(BuildContext context) {
  return RotatingLoader();
}

class RotatingLoader extends StatefulWidget {
  @override
  _RotatingLoaderState createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: const Opacity(
            opacity: 0.4,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          child: AssetsHelper.getAssetImage(
              name: 'img_app_loading.png',
              fit: BoxFit.cover,
              height: 60.0,
              width: 60.0
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * 3.141592653589793,
              child: child,
            );
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.4,
          child: Text(
            "Loading...",
            style: Fonts.textStyleSemiBold.copyWith(
              fontSize: 16,
              color: AppColor.appWhiteColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

