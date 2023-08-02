import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/upload_manually_controller.dart';

class UploadManuallyView extends GetView<UploadManuallyController> {
  UploadManuallyView({Key? key, this.amount}) : super(key: key);
  final UploadManuallyController uploadManuallyController =
      Get.put(UploadManuallyController());
  final amount;

  @override
  Widget build(BuildContext context) {
    uploadManuallyController.amountEditingController.text = amount.toString();
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
        child: WillPopScope(
          onWillPop: () async {
            uploadManuallyController.screenShot = "";
            Get.back();
            throw Exception;
          },
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
                          uploadManuallyController.screenShot = "";
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
                  'Upload Screenshot',
                  style: GoogleFonts.jost(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4956b2),
                  ),
                ),
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                    child: Column(
                      children: [
                        Text(
                          "Enter the Amount",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff4956b2)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          controller:
                              uploadManuallyController.amountEditingController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                              // suffixIcon: Icon(Icons.search),
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                              hintText: "|",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 18),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 199, 199, 179))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(16)),
                              fillColor: Color.fromARGB(153, 255, 255, 255),
                              focusColor: Color.fromARGB(255, 231, 231, 231)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GetBuilder<UploadManuallyController>(
                            builder: (constext) {
                          return Text(
                            constext.screenShot == ""
                                ? "Upload Screenshot of payment"
                                : "Screenshot of payment",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4956b2)),
                          );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<UploadManuallyController>(builder: (cont) {
                          return Visibility(
                            visible: cont.screenShot == "" ? true : false,
                            child: Container(
                                height: 47,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color.fromARGB(153, 255, 255, 255)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent)),
                                        onPressed: () async {
                                          cont.pickimage2();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Color(0xff4956b2),
                                        )))),
                          );
                        }),
                        GetBuilder<UploadManuallyController>(builder: (con) {
                          return Visibility(
                            visible: con.screenShot == "" ? false : true,
                            child: InkWell(
                              onTap: () {
                                con.pickimage2();
                              },
                              child: Container(
                                  width: 100.w,
                                  child: (con.screenShot == "")
                                      ? Image.asset(
                                          "assets/images/invoice_image.png")
                                      : Image.memory(Base64Decoder()
                                          .convert(con.screenShot))),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 30.w,
                        height: 40,
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
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Obx(() {
                              return ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () {
                                    if (uploadManuallyController.screenShot ==
                                        "") {
                                      Get.snackbar(
                                          "Error", "Please upload image",
                                          backgroundColor: Colors.red);
                                      return;
                                    }

                                    uploadManuallyController.uploadManually(
                                        uploadManuallyController
                                            .amountEditingController.text,
                                        context);
                                  },
                                  child: uploadManuallyController
                                              .isUploadLoading.value ==
                                          true
                                      ? Container(
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : Text(
                                          "Upload",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white),
                                        ));
                            }))),
                  ],
                ),
              )),
        ));
  }
}
