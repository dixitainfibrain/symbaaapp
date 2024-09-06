import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'SplashViewModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  SplashViewModel splashViewModel = SplashViewModel();
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    splashViewModel.init(context);
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..addListener(() {
        if (controller?.status == AnimationStatus.completed) {
          splashViewModel.navigationPage();
        }
      });
    controller?.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => splashViewModel,
      child: Consumer<SplashViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Lottie.asset(
                'assets/anim/splash_animation.json',
                controller: controller,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
