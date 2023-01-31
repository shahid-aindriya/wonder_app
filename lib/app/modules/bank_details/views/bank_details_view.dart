import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/success/views/success_view.dart';

import '../controllers/bank_details_controller.dart';

class BankDetailsView extends GetView<BankDetailsController> {
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
          title: Text(
            'Bank Details',
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'Account Holder Name',
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
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        hintText: "Enter Full Name",
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
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
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
                          'Account Number',
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
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        hintText: "Enter Account Number",
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
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
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
                          'Confirm Account Number',
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
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        hintText: "Re-Enter Account Number",
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
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
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
                          'IFSC Code',
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
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        hintText: "Enter IFSC Code",
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
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
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
                          'Branch Name',
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
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        hintText: "Enter Branch Name",
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
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
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
                          'Upload Cancelled Check image',
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                              hintText: "Browse Files",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      topLeft: Radius.circular(16)),
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
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      topLeft: Radius.circular(16))),
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
                      Container(
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
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(SuccessView());
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
