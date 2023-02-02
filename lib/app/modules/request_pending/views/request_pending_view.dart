import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/login/views/login_view.dart';

import '../../../data/colors.dart';
import '../controllers/request_pending_controller.dart';

class RequestPendingView extends GetView<RequestPendingController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.png"),
              fit: BoxFit.cover)),
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
                      Get.offAll(LoginView());
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff4956b2),
                    )),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      // Get.to(StoreDetailsView());
                    },
                    child: Container(
                        width: 95.w,
                        height: 256,
                        child: Stack(children: <Widget>[
                          Positioned(
                              top: 59,
                              left: 0,
                              child: Container(
                                  width: 95.w,
                                  height: 197,
                                  child: Stack(children: <Widget>[
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          width: 95.w,
                                          height: 197,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            gradient: LinearGradient(
                                                begin: Alignment(
                                                    1.0684057474136353,
                                                    0.011194117367267609),
                                                end: Alignment(
                                                    -0.011194117367267609,
                                                    0.014712272211909294),
                                                colors: [
                                                  Color.fromRGBO(255, 255, 255,
                                                      0.8500000238418579),
                                                  Color.fromRGBO(255, 255, 255,
                                                      0.6899999976158142)
                                                ]),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Text(
                                                  "Registration Request Pending",
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.roboto(
                                                      color: textGradientBlue,
                                                      fontSize: 20.sp,
                                                      letterSpacing:
                                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.95),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 10.w,
                                                    left: 10.w,
                                                  ),
                                                  child: Text(
                                                    "Your request for registration is under verification. We’ll get you notified when it is approved .",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                        color: textSemiGrey,
                                                        fontSize: 16.sp,
                                                        letterSpacing:
                                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        height: 1.5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  ]))),
                          Positioned(
                              top: 0,
                              left: 35.w,
                              child: Container(
                                  width: 25.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/image 11.png'),
                                        fit: BoxFit.fitWidth),
                                  ))),
                        ])),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
