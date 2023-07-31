import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';import 'package:wonder_app/app/modules/shop_details/controllers/shop_details_controller.dart';

import '../../../data/urls.dart';
import '../../my_shops/model/shops_list_model.dart';

// ignore: must_be_immutable
class BankDetailsOfShop extends StatelessWidget {
  BankData data;
  final image;
  final accountNumber;
  final holderName;
  final ifscCode;
  final accounType;
  final shopId;
  final bankId;
  BankDetailsOfShop(
      {super.key,
      this.image,
      this.bankId,
      this.shopId,
      required this.data,
      this.accountNumber,
      this.accounType,
      this.holderName,
      this.ifscCode});
  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController accounumberController =
        TextEditingController(text: accountNumber);
    final TextEditingController holderNameController =
        TextEditingController(text: holderName);
    final TextEditingController ifscCodeController =
        TextEditingController(text: ifscCode);
    final TextEditingController accountTypeController =
        TextEditingController(text: accounType);
    // final TextEditingController branchNameController = TextEditingController();
    final formkey = GlobalKey<FormState>();
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
              SizedBox(height: 5.h),
              Form(
                key: formkey,
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
                        enabled: true,
                        controller: holderNameController,
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
                              value.length < 3 ||
                              value == "null") {
                            return 'please enter valid name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
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
                        controller: accounumberController,
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
                        height: 20,
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
                              value.length < 3 ||
                              value == "null") {
                            return 'Enter Valid type like current,savings or credit';
                          } else {
                            return null;
                          }
                        },
                      ),

                      //   SizedBox(
                      //   height: 30,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 14.0),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'Branch Name',
                      //         style: GoogleFonts.roboto(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w400,
                      //           height: 1.1725,
                      //           color: Color(0xff4956b2),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // TextFormField(
                      //   controller: branchNameController,
                      //   enabled: true,
                      //   style: GoogleFonts.roboto(
                      //       fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      //   decoration: InputDecoration(
                      //       hintStyle: GoogleFonts.roboto(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w300,
                      //         height: 1.1725,
                      //         color: Color.fromARGB(93, 0, 0, 0),
                      //       ),
                      //       hintText: "Enter Branch Name",
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           vertical: 18.0, horizontal: 18),
                      //       enabled: true,
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(16),
                      //           borderSide: BorderSide(
                      //               width: 0,
                      //               color: Color.fromARGB(255, 199, 199, 179))),
                      //       filled: true,
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               width: 0,
                      //               color: Color.fromARGB(255, 255, 255, 255)),
                      //           borderRadius: BorderRadius.circular(16)),
                      //       fillColor: Color.fromARGB(153, 255, 255, 255),
                      //       focusColor: Color.fromARGB(255, 231, 231, 231)),
                      //   validator: (value) {
                      //     if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value!) ||
                      //         value.length < 3) {
                      //       return 'Incorrect branch name';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Cheque Copy',
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
                      GetBuilder<ShopDetailsController>(builder: (condftext) {
                        return Visibility(
                          visible: shopDetailsController.checkImage == ''
                              ? true
                              : false,
                          child: InkWell(
                            onTap: () {
                              shopDetailsController.showPopup(
                                  context,
                                  (value) => shopDetailsController
                                      .pickCheckImage(value));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 20),
                              child: Container(
                                  width: 100.w,
                                  child: (image == null || image == "null")
                                      ? Image.asset(
                                          "assets/images/invoice_image.png")
                                      : Image.network(
                                          "$baseUrlForImage${data.chequeCopy}")),
                            ),
                          ),
                        );
                      }),
                      GetBuilder<ShopDetailsController>(builder: (condft2ext) {
                        return Visibility(
                          visible: shopDetailsController.checkImage == ''
                              ? false
                              : true,
                          child: InkWell(
                            onTap: () {
                              shopDetailsController.showPopup(
                                  context,
                                  (value) => shopDetailsController
                                      .pickCheckImage(value));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 20),
                              child: Container(
                                width: 100.w,
                                child: Image.memory(Base64Decoder()
                                    .convert(shopDetailsController.checkImage)),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 90,
            child: Row(
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
                    child: ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(100, 50)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        log(bankId.toString());
                        if (formkey.currentState!.validate()) {
                          if (bankId == "null") {
                            shopDetailsController.addBankDetailss(
                              context: context,
                              accType: accountTypeController.text,
                              accountNum:
                                  int.tryParse(accounumberController.text),
                              ifscCode: ifscCodeController.text,
                              name: holderNameController.text,
                            );
                          } else {
                            shopDetailsController.editBankDetails(
                                acctype: accountTypeController.text,
                                ifsc: ifscCodeController.text,
                                name: holderNameController.text,
                                accnumber:
                                    int.tryParse(accounumberController.text),
                                bankId: bankId);
                          }
                        }
                      },
                      child: Text(
                        'Save',
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
          ),
        ));
  }
}
