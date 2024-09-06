import 'package:flutter/material.dart';
import 'dart:math' as math;

class CommonWidget {

  static Widget getFieldSpacer({double? height, double? width}) {
    return SizedBox(
      height: height ?? 10.0,
      width: width ?? 0.0,
    );
  }

  static Widget getPlaceHolderImage(String image) {
    return Image.asset('assets/images/$image');
  }

  static BoxDecoration backGroundDecoration({required String backgroundImage, double? opacity, double? borderRadius}) {
    return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$backgroundImage'),
          fit: BoxFit.cover,
          opacity: opacity ?? 1
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 0)
    );
  }


  static List<BoxShadow> getBottomShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        offset: const Offset(0.0, 3.0),
        blurRadius: 6.0,
      ),
    ];
  }

}


