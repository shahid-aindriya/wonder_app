import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../password_generation/views/password_generation_view.dart';
import '../controllers/seller_regist_controller.dart';

class SellerRegistView extends GetView<SellerRegistController> {
  @override
  final SellerRegistController controller = Get.put(SellerRegistController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameEditingController = TextEditingController();
    final TextEditingController phoneNumberEditingController =
        TextEditingController();
    final TextEditingController adhaarNumberEditingController =
        TextEditingController();
    final TextEditingController panNumberEditingController =
        TextEditingController();
    final TextEditingController emailEditingController =
        TextEditingController();
    final TextEditingController vendorEmailEditingController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    final formKeyForEmail = GlobalKey<FormState>();
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
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to WonderApp',
                      style: GoogleFonts.jost(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.445,
                        color: Color(0xff4956b2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'Register your store at WonderApp & get unlimited benefits on the go!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.445,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                height: 112,
                child: Image.asset(
                  "assets/images/handshake.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => Radio<int>(
                                          fillColor: MaterialStateProperty.all(
                                              Color(0xff4956b2)),
                                          value: 0,
                                          groupValue: controller
                                              .selectedDiscountValue.value,
                                          onChanged: (value) {
                                            controller.changeRadioVal(value);
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'No Referral',
                                          style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            height: 1.1725,
                                            color: Color(0xff4956b2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: Row(
                                //     children: [
                                //       Obx(
                                //         () => Radio<int>(
                                //           fillColor: MaterialStateProperty.all(
                                //               Color(0xff4956b2)),
                                //           value: 1,
                                //           groupValue: controller
                                //               .selectedDiscountValue.value,
                                //           onChanged: (value) {
                                //             controller.changeRadioVal(value);
                                //           },
                                //         ),
                                //       ),
                                //       Flexible(
                                //         child: Text(
                                //           'Referred by Business Rep',
                                //           style: GoogleFonts.roboto(
                                //             fontSize: 13,
                                //             fontWeight: FontWeight.w500,
                                //             height: 1.1725,
                                //             color: Color(0xff4956b2),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Expanded(
                                  child: Row(
                                    // crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Obx(
                                        () => Radio<int>(
                                          fillColor: MaterialStateProperty.all(
                                              Color(0xff4956b2)),
                                          value: 2,
                                          groupValue: controller
                                              .selectedDiscountValue.value,
                                          onChanged: (value) {
                                            controller.changeRadioVal(value);
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: Text('Referred by Vendor',
                                            softWrap: true,
                                            style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              height: 1.1725,
                                              color: Color(0xff4956b2),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // GetBuilder<SellerRegistController>(builder: (c) {
                          //   return Row(
                          //     children: [
                          //       Container(
                          //         height: 20,
                          //         width: 20,
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: Checkbox(
                          //           checkColor: Color(0xff4956b2),
                          //           activeColor:
                          //               Color.fromARGB(255, 255, 255, 255),
                          //           fillColor: MaterialStateProperty.all(
                          //               Color.fromARGB(255, 255, 255, 255)),
                          //           value: c.isChecked,
                          //           onChanged: (value) {
                          //             c.checkBox(value);
                          //           },
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 8,
                          //       ),
                          //       Text("Signing up by Business Representative",
                          //           style: GoogleFonts.roboto(
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.w400,
                          //               height: 1.1725,
                          //               color: Color(0xff4956b2)))
                          //     ],
                          //   );
                          // }),
                          SizedBox(
                            height: 25,
                          ),

                          Obx(() {
                            return Visibility(
                              visible:
                                  controller.selectedDiscountValue.value == 2
                                      ? true
                                      : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Email of Referring Vendor',
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
                                  Form(
                                    key: formKeyForEmail,
                                    child: TextFormField(
                                      controller: vendorEmailEditingController,
                                      enabled: true,
                                      keyboardType: TextInputType.emailAddress,
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1)),
                                      decoration: InputDecoration(
                                          hintStyle: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            height: 1.1725,
                                            color: Color.fromARGB(93, 0, 0, 0),
                                          ),
                                          hintText: "Enter your email",
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 18.0, horizontal: 18),
                                          enabled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: Color.fromARGB(
                                                      255, 199, 199, 179))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: Color.fromARGB(
                                                      255, 199, 199, 179))),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: Color.fromARGB(
                                                      255, 199, 199, 179))),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)), borderRadius: BorderRadius.circular(16)),
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
                                      onFieldSubmitted: (value) {
                                        if (formKeyForEmail.currentState!
                                            .validate()) {
                                          controller.getVendors(value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 18,
                          ),

                          Obx(() {
                            return Visibility(
                              visible:
                                  controller.selectedDiscountValue.value == 2
                                      ? true
                                      : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Select Referring Vendor',
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
                                  Container(
                                      width: 100.w,
                                      height: 50,
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        isDense: true,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                        decoration: InputDecoration(
                                            hintStyle: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              height: 1.1725,
                                              color:
                                                  Color.fromARGB(93, 0, 0, 0),
                                            ),
                                            hintText: "Select vendor",
                                            enabled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
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
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            fillColor: Color.fromARGB(
                                                153, 255, 255, 255),
                                            focusColor: Color.fromARGB(
                                                255, 231, 231, 231)),
                                        value: controller.selectRepId,
                                        onChanged: (value) async {
                                          controller.selectRepId = value;
                                        },
                                        items: controller.repsList.map((data) {
                                          return DropdownMenuItem(
                                              value: data['id'],
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Text(
                                                  data['phone'],
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ));
                                        }).toList(),
                                      ))
                                ],
                              ),
                            );
                          }),
                          GetBuilder<SellerRegistController>(builder: (c) {
                            return Visibility(
                              visible: c.selectedDiscountValue.value == 1
                                  ? true
                                  : false,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Select Business Representative',
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
                                  Obx(() {
                                    return FutureBuilder(
                                        future: controller.getReps(),
                                        builder: (context, snapshot) {
                                          return Container(
                                              width: 100.w,
                                              height: 50,
                                              child: DropdownButtonFormField(
                                                isExpanded: true,
                                                isDense: true,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                                decoration: InputDecoration(
                                                    hintStyle:
                                                        GoogleFonts.roboto(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      height: 1.1725,
                                                      color: Color.fromARGB(
                                                          93, 0, 0, 0),
                                                    ),
                                                    hintText:
                                                        "Select Representative",
                                                    enabled: true,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16),
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
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16)),
                                                    fillColor: Color.fromARGB(
                                                        153, 255, 255, 255),
                                                    focusColor: Color.fromARGB(255, 231, 231, 231)),
                                                value: controller.selectRepId,
                                                onChanged: (value) async {
                                                  controller.selectRepId =
                                                      value;
                                                },
                                                items: controller.repsList
                                                    .map((data) {
                                                  return DropdownMenuItem(
                                                      value: data['id'],
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5.0),
                                                        child: Text(
                                                          data['phone'],
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ));
                                                }).toList(),
                                              ));
                                        });
                                  })
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Seller Name',
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
                            controller: nameEditingController,
                            enabled: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter your name...",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
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
                              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Seller Email',
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
                            controller: emailEditingController,
                            enabled: true,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter your email",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
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
                              if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                                      .hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Phone Number',
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
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: phoneNumberEditingController,
                            enabled: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter Phone Number",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (!RegExp(r"^\d{10}$").hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Aadhar Number',
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
                            maxLength: 12,
                            controller: adhaarNumberEditingController,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {}, icon: Icon(Icons.my_location)),
                                // suffix: Container(
                                //   height: 23,
                                //   child: Image.asset(
                                //     "assets/images/store_location.png",
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter 12 digit number",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (!RegExp(r"^\d{12}$").hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid adhaar ';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          // Text(
                          //   'Upload Store Photo',
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //     height: 1.1725,
                          //     color: Color(0xff4956b2),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   width: 146,
                          //   height: 139,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(13),
                          //       color: Colors.white
                          //       // gradient: LinearGradient(
                          //       //   begin: Alignment(-0.696, -0),
                          //       //   end: Alignment(1.161, 1.413),
                          //       //   colors: <Color>[Color(0x97ffffff), Color(0x7bffffff)],
                          //       //   stops: <double>[0, 1],
                          //       // ),
                          //       ),
                          //   child: Center(
                          //       child: Icon(Icons.add,
                          //           size: 41,
                          //           color: Color.fromARGB(255, 73, 86, 178))),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Aadhar Card Photo',
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
                          GetBuilder<SellerRegistController>(
                              builder: (contextj) {
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
                                          color: Color.fromARGB(167, 0, 0, 0),
                                        ),
                                        hintText: controller.adhaarimg == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 199, 199, 179))),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.showPopup(context, true);
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
                          SizedBox(
                            height: 29,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'PAN Number',
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
                            controller: panNumberEditingController,
                            enabled: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {}, icon: Icon(Icons.my_location)),
                                // suffix: Container(
                                //   height: 23,
                                //   child: Image.asset(
                                //     "assets/images/store_location.png",
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Eg. ABCDE1234E",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
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
                              if (!RegExp(r"^[A-Z]{5}\d{4}[A-Z]{1}$")
                                      .hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid Pan number and in Capital letters';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'PAN Card Photo',
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
                          GetBuilder<SellerRegistController>(
                              builder: (contexts) {
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
                                          color: Color.fromARGB(167, 0, 0, 0),
                                        ),
                                        hintText: controller.panimg == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 199, 199, 179))),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    controller.showPopup(context, false);
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
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 124,
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          if (controller.panimg == '' ||
                              controller.adhaarimg == '') {
                            log(controller.selectRepId.toString());
                            controller.snackBar(
                                context: context,
                                text: "Aadhar and pan photo is mandatory");
                            return;
                          } else if (!(formKey.currentState!.validate())) {
                            controller.snackBar(
                                context: context,
                                text: "Please fill all fileds properly");
                          } else {
                            // log(controller.selectRepId.toString());
                            Get.to(PasswordGenerationView(
                              adhaarNumber: adhaarNumberEditingController.text,
                              adhaarimag: controller.adhaarimg,
                              name: nameEditingController.text,
                              panImag: controller.panimg,
                              panNumber: panNumberEditingController.text,
                              phoneNmber: phoneNumberEditingController.text,
                              email: emailEditingController.text,
                              repId: controller.selectRepId,
                            ));
                          }
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.2110513051,
                            color: Color(0xffffffff),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 52,
              ),
            ],
          )),
    );
  }
}
