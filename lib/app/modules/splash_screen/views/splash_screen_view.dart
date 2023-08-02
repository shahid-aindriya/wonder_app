import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 63, 70, 189),
      Color.fromARGB(255, 65, 125, 232)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final SplashScreenController spls = Get.put(SplashScreenController());
  SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    spls.checkLogin();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(2, 1.0548897981643677),
            end: Alignment(-1.0548897981643677, 1.226324439048767),
            colors: [
              Color.fromRGBO(239, 221, 214, 1),
              Color.fromRGBO(220, 222, 242, 1),
              Color.fromRGBO(250, 227, 243, 1),
              Color.fromRGBO(228, 249, 254, 1)
            ]),
      ),
      child: UpgradeAlert(
        upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, bottom: 5.h, right: 5.w, left: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Wonder App',
                      //   style: GoogleFonts.jost(
                      //       fontSize: 26.sp,
                      //       fontWeight: FontWeight.w700,
                      //       height: 0.5,
                      //       foreground: Paint()..shader = linearGradient),
                      // ),
                      Flexible(
                        child: Image.asset(
                          "assets/images/Wonderpoints (1).png",
                          width: 60.w,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 23.h,
                  child: Image.asset(
                    "assets/images/login_image.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
