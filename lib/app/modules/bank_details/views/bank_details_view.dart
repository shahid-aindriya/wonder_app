import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/bank_details_controller.dart';

class BankDetailsView extends GetView<BankDetailsController> {
  final shopId;

  BankDetailsView({this.shopId});
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final BankDetailsController bankDetailsController =
      Get.put(BankDetailsController());
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
                      controller: holderNameController,
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
                        if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value!) ||
                            value.length < 3) {
                          return 'please enter valid name';
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
                      controller: accountNumberController,
                      enabled: true,
                      keyboardType: TextInputType.number,
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
                        if (!RegExp(r'^[0-9]{10,20}$').hasMatch(value!) ||
                            value.length < 3) {
                          return 'please enter valid account number';
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
                      keyboardType: TextInputType.number,
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
                        if (!RegExp(r'^[0-9]{10,20}$').hasMatch(value!) ||
                            value != accountNumberController.text) {
                          return 'Account number doesnt matches';
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
                      controller: ifscCodeController,
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
                        if (!RegExp(r'^[A-Za-z]{4}[a-zA-Z0-9]{7}$')
                            .hasMatch(value!)) {
                          return 'Invalid IFSC Code';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Row(
                        children: [
                          Text(
                            'Account Type',
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
                      controller: accountTypeController,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.1725,
                            color: Color.fromARGB(93, 0, 0, 0),
                          ),
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
                        if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value!) ||
                            value.length < 3) {
                          return 'Enter Valid type like current,savings or credit';
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
                      controller: branchNameController,
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
                        if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value!) ||
                            value.length < 3) {
                          return 'Incorrect branch name';
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
                    GetBuilder<BankDetailsController>(builder: (context) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: true,
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
                                  hintText:
                                      bankDetailsController.chequeImage == ''
                                          ? "Browse Files"
                                          : "Uploaded",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18.0, horizontal: 18),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
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
                                  fillColor: Color.fromARGB(153, 255, 255, 255),
                                  focusColor:
                                      Color.fromARGB(255, 231, 231, 231)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              bankDetailsController.pickimage();
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
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (bankDetailsController.chequeImage == '') {
                              MotionToast.warning(
                                dismissable: true,
                                enableAnimation: false,
                                position: MotionToastPosition.top,
                                title: const Text(
                                  'Error ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                description:
                                    const Text('Please Upload cheque image'),
                                animationCurve: Curves.bounceIn,
                                borderRadius: 0,
                                animationDuration:
                                    const Duration(milliseconds: 1000),
                              ).show(context);
                            } else if (formKey.currentState!.validate()) {
                              bankDetailsController.addBankDetails(
                                  accType: accountTypeController.text,
                                  accountNum: int.tryParse(
                                      accountNumberController.text),
                                  ifscCode: ifscCodeController.text,
                                  name: holderNameController.text,
                                  shopId: shopId);
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
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
