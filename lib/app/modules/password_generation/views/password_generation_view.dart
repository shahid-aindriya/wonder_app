import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sizer/sizer.dart';

import '../controllers/password_generation_controller.dart';

// ignore: must_be_immutable
class PasswordGenerationView extends GetView<PasswordGenerationController> {
  String? name;
  String? phoneNmber;
  String? adhaarNumber;
  String? adhaarimag;
  String? panNumber;
  String? panImag;
  String? email;
  final repId;
  @override
  final PasswordGenerationController controller =
      Get.put(PasswordGenerationController());
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  PasswordGenerationView(
      {this.adhaarNumber,
      this.name,
      this.adhaarimag,
      this.repId,
      this.panImag,
      this.panNumber,
      this.phoneNmber,
      this.email});

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
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(117, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff4956b2),
                    )),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Create Password',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Enter a new password',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          controller.isOn.value = false;
                        },
                        controller: passwordController,
                        enabled: true,
                        obscureText: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "**************",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 18),
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
                          if (value!.length < 6) {
                            return 'minimum length is 6';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 1.h),
                        child: Text(
                          "Use combinations of alphabets, numbers & symbols to strengthen your password ",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(140, 0, 0, 0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0, top: 2.h),
                        child: Row(
                          children: [
                            Text(
                              'Re-enter the password',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: true,
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "**************",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 18),
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
                          if (value != passwordController.text) {
                            return 'password doesnt matches';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 1.2,
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: Text(
                              "Or",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 1.2,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      // Figma Flutter Generator Rectangle47Widget - RECTANGLE
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          gradient: LinearGradient(
                              begin: Alignment(
                                  1.0684057474136353, 0.011194117367267609),
                              end: Alignment(
                                  -0.011194117367267609, 0.014712272211909294),
                              colors: [
                                Color.fromRGBO(
                                    255, 255, 255, 0.8500000238418579),
                                Color.fromRGBO(
                                    255, 255, 255, 0.6899999976158142)
                              ]),
                        ),
                        child: Column(
                          children: [
                            Obx(() {
                              return RadioListTile(
                                toggleable: true,
                                value: true,
                                groupValue: controller.isOn.value,
                                onChanged: (val) {
                                  controller.setSelectedRadio();
                                  passwordController.clear();
                                  confirmPasswordController.clear();
                                },
                                title: Text(
                                  'Auto-generate Password',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1725,
                                    color: Color.fromARGB(255, 77, 96, 221),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 1.h),
                        child: Text(
                          "By selecting this option an auto-generated password will be sent to your registered email ",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(140, 0, 0, 0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border(),
                              gradient: LinearGradient(
                                begin: Alignment(-0.934, -1),
                                end: Alignment(1.125, 1.333),
                                colors: <Color>[
                                  Color(0xe53f46bd),
                                  Color(0xe5417de8)
                                ],
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: Obx(() {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      elevation: MaterialStateProperty.all(0)),
                                  onPressed: controller.isLoading.value == true
                                      ? null
                                      : () async {
                                          if (passwordController.text.isEmpty &&
                                              controller.isOn.value == false) {
                                            MotionToast.error(
                                              position: MotionToastPosition.top,
                                              title: const Text(
                                                'Error ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              description: const Text(
                                                  'Please Enter Password'),
                                              animationCurve: Curves.bounceIn,
                                              borderRadius: 0,
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                            ).show(context);
                                          } else if (passwordController.text !=
                                              confirmPasswordController.text) {
                                            MotionToast.error(
                                              position: MotionToastPosition.top,
                                              title: const Text(
                                                'Error ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              description: const Text(
                                                  'Password doesnt matches'),
                                              animationCurve: Curves.bounceIn,
                                              borderRadius: 0,
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                            ).show(context);
                                          } else if (passwordController
                                                      .text.length <
                                                  6 &&
                                              (controller.isOn.value ==
                                                  false)) {
                                            MotionToast.error(
                                              position: MotionToastPosition.top,
                                              title: const Text(
                                                'Error ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              description: const Text(
                                                  'Minimum 6 characters'),
                                              animationCurve: Curves.bounceIn,
                                              borderRadius: 0,
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                            ).show(context);
                                          } else {
                                            await controller.sellerRegister(
                                                adarImag: adhaarimag,
                                                adhaar: adhaarNumber,
                                                email: email,
                                                name: name,
                                                pan: panNumber,
                                                panImag: panImag,
                                                password:
                                                    passwordController.text,
                                                phone: phoneNmber,
                                                context: context,
                                                repId: repId);
                                          }
                                        },
                                  child: controller.isLoading.value == false
                                      ? Text(
                                          'Save',
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2110513051,
                                            color: Color(0xffffffff),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Processing",
                                              style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2110513051,
                                                color: Color(0xffffffff),
                                              ),
                                            )
                                          ],
                                        ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
