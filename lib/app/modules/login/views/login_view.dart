import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/otp_verification/views/otp_verification_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 63, 70, 189),
      Color.fromARGB(255, 65, 125, 232)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 17.h, bottom: 5.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Seller Login',
                  style: GoogleFonts.roboto(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    height: 0.6785714286,
                    color: Color.fromARGB(175, 0, 0, 0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your phone number ',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.1875,
                    color: Color(0xff888888),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: TextFormField(
                enabled: true,
                style: GoogleFonts.roboto(
                    fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                decoration: InputDecoration(
                    prefixText: "+91 ",
                    prefixStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400, fontSize: 18),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 6.0, left: 2),
                      child: Image.asset('assets/images/flag.png'),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 17.0, horizontal: 10),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 199, 199, 179))),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(16)),
                    fillColor: Color.fromARGB(153, 255, 255, 255),
                    focusColor: Color.fromARGB(255, 231, 231, 231)),
                validator: (value) {
                  if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                          .hasMatch(value!) ||
                      value.length < 3) {
                    return 'please enter valid email';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 25.h,
              child: Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              'By clicking login, you agree to our terms and policies',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                height: 1.6428571429,
                color: Color(0xff000000),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(OtpVerificationView());
                  },
                  child: Container(
                    width: 189,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(),
                      gradient: LinearGradient(
                        begin: Alignment(-0.934, -1),
                        end: Alignment(1.125, 1.333),
                        colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
                        stops: <double>[0, 1],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0.7870440483),
                          blurRadius: 2.7546541691,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.2110513051,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
