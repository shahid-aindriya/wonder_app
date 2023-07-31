import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';

import '../../seller_regist/views/seller_regist_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 63, 70, 189),
      Color.fromARGB(255, 65, 125, 232)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final LoginController loginController = Get.put(LoginController());
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
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
            SizedBox(height: 1.5.h),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: TextFormField(
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      enabled: true,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 17.0, horizontal: 10),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
                          errorBorder: OutlineInputBorder(
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
                  SizedBox(height: 1.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Obx(() {
                      return TextFormField(
                        obscureText: loginController.obscureText.value,
                        controller: passwordEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 17.0, horizontal: 10),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.changeText();
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color:
                                      loginController.obscureText.value == false
                                          ? Colors.blue
                                          : Colors.grey,
                                )),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 199, 199, 179))),
                            errorBorder: OutlineInputBorder(
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
                          if (value == null || value.isEmpty) {
                            return 'please enter password';
                          } else {
                            return null;
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
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
                Container(
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
                    child: Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 31.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: loginController.isLoading.value == true
                              ? null
                              : () {
                                  if (formkey.currentState!.validate()) {
                                    loginController.loginFunct(
                                        password:
                                            passwordEditingController.text,
                                        email: emailEditingController.text,
                                        context: context);
                                  }
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (loginController.isLoading.value == true)
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              SizedBox(width: 10),
                              Text(
                                loginController.isLoading.value == true
                                    ? 'Processing'
                                    : 'LOGIN',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2110513051,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New to Wonder App?",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    )),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            // Figma Flutter Generator Rectangle41Widget - RECTANGLE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(SellerRegistView());
                  },
                  child: Container(
                    width: 45.w,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                            offset: Offset(0, 2.7899999618530273),
                            blurRadius: 7.510000228881836)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 0.8999999761581421),
                    ),
                    child: Center(
                        child: Text("Register Now",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2110513051,
                                color: Color.fromARGB(255, 77, 96, 221)))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
