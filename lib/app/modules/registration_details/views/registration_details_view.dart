import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/gst_details/views/gst_details_view.dart';

import '../controllers/registration_details_controller.dart';

class RegistrationDetailsView extends GetView<RegistrationDetailsController> {
  final shopName;
  final shopAdress;
  final shopLocation;
  final categoryId;
  final shopImage;
  final gstPercentage;
  final commission;
  final featured;
  final closingTime;
  final openingTime;
  RegistrationDetailsView(
      {this.shopName,
      this.closingTime,
      this.openingTime,
      this.gstPercentage,
      this.commission,
      this.shopAdress,
      this.shopLocation,
      this.categoryId,
      this.featured,
      this.shopImage});
  @override
  final TextEditingController licenseController = TextEditingController();
  @override
  final RegistrationDetailsController controller =
      Get.put(RegistrationDetailsController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wonder_app_background.jpg"),
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
              title: Text(
                'License Details',
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
                                'License Number',
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
                          controller: licenseController,
                          enabled: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                              hintText: "License Number",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18),
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
                            if (value!.length < 3) {
                              return 'please enter valid number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Row(
                            children: [
                              Text(
                                'Upload Document',
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
                        GetBuilder<RegistrationDetailsController>(
                            builder: (contexta) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                  decoration: InputDecoration(
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        height: 1.1725,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      hintText: controller.licenceImage == ''
                                          ? "Browse Document"
                                          : 'Uploaded',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 18.0, horizontal: 18),
                                      enabled: true,
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              topLeft: Radius.circular(16)),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(
                                                  255, 199, 199, 179))),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              topLeft: Radius.circular(16))),
                                      fillColor:
                                          Color.fromARGB(153, 255, 255, 255),
                                      focusColor:
                                          Color.fromARGB(255, 231, 231, 231)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.pickimage();
                                },
                                child: Container(
                                  width: 100,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
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
                                  child: Center(
                                    child: Text(
                                      'Upload',
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
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 100,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Get.off(GstDetailsView(
                              categoryId: categoryId,
                              licenceImage: controller.licenceImage,
                              licenceNumber: licenseController.text,
                              shopAdress: shopAdress,
                              shopImage: shopImage,
                              shopLocation: shopLocation,
                              shopName: shopName,
                              commission: commission,
                              featured: featured,
                            ));
                          }
                        },
                        child: Container(
                          width: 124,
                          height: 50,
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
                          child: Center(
                            child: Text(
                              'Next',
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
                  )),
            )));
  }
}
