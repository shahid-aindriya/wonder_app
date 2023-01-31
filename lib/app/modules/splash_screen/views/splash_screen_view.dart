import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 228),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wonder App',
                    style: GoogleFonts.jost(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        height: 0.5,
                        foreground: Paint()..shader = linearGradient),
                  ),
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
    );
  }
}
