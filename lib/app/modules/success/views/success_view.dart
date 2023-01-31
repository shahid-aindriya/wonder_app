import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/colors.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../controllers/success_controller.dart';

class SuccessView extends GetView<SuccessController> {
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
        ),
        body: Column(
          children: [
            // Figma Flutter Generator Group183Widget - GROUP
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
              child: Center(
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
                                        borderRadius: BorderRadius.circular(13),
                                        gradient: LinearGradient(
                                            begin: Alignment(1.0684057474136353,
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
                                              "Request Submitted Successfully",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.roboto(
                                                  color: textGradientBlue,
                                                  fontSize: 20.sp,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.w500,
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
                                                "Your request for registration is under verification. We’ll get you notified when it is approved by the admin.",
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
                                    image:
                                        AssetImage('assets/images/success.png'),
                                    fit: BoxFit.fitWidth),
                              ))),
                    ])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(InvoiceView());
                  },
                  child: Container(
                    width: 185,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(),
                      gradient: LinearGradient(
                        begin: Alignment(-0.934, -1),
                        end: Alignment(1.125, 1.333),
                        colors: <Color>[
                          buttonGradientColor1,
                          buttonGradientColor2
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
                    child: Center(
                      child: Text(
                        'Go to my invoice',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.2110513051,
                          color: textWhiteColor,
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
