import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/choose_vendor_controller.dart';

class ChooseVendorView extends GetView<ChooseVendorController> {
  ChooseVendorView({Key? key}) : super(key: key);
  final ChooseVendorController chooseVendorController =
      Get.put(ChooseVendorController());
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
          // title: Text(
          //   'Chat List',
          //   style: GoogleFonts.jost(
          //     fontSize: 22,
          //     fontWeight: FontWeight.w500,
          //     color: Color(0xff4956b2),
          //   ),
          // ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(13),
                    color: Color.fromARGB(255, 243, 243, 245)),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 8.0, top: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      Image.asset("assets/images/choose_vendor.png"),
                      Text(
                        "Earn Commission on \n Every Vendor Sign-ups!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color.fromARGB(255, 3, 70, 189)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "You can earn sales commission as more as \n vendors sign up under you.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You can choose how to add vendors under you.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "The bigger is the sale, bigger will be the commission. Choose wisely...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Color(0xff4956b2),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 23),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(13),
                    color: Color.fromARGB(255, 243, 243, 245)),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 8.0, top: 20, left: 8, right: 8),
                  child: Column(
                    children: [
                      Text(
                        "Select how to add vendors \n under you",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            color: Color(0xff3F46BD),
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    chooseVendorController.selectValue(false);
                                  },
                                  child: Obx(() {
                                    return chooseVendorController
                                                .selected.value !=
                                            false
                                        ? SvgPicture.asset(
                                            "assets/images/choose_vendor_automatic.svg")
                                        : SvgPicture.asset(
                                            "assets/images/selected_choose_auto.svg");
                                  }),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "System will automatically add vendors under you",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              "  OR  ",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    chooseVendorController.selectValue(true);
                                  },
                                  child: Obx(() {
                                    return chooseVendorController
                                                .selected.value ==
                                            true
                                        ? SvgPicture.asset(
                                            "assets/images/selected_choose_manual.svg")
                                        : SvgPicture.asset(
                                            "assets/images/choose_vendor_manual.svg");
                                  }),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "You can select whom to be added under you",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Container(
            height: 40,
            width: 89,
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
            child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () async {},
                    child: Text(
                      "Save",
                      style: GoogleFonts.roboto(color: Colors.white),
                    )))),
      ),
    );
  }
}
