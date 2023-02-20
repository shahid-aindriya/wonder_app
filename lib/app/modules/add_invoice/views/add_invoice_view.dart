import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/add_invoice/widgets/searcg.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';

import '../controllers/add_invoice_controller.dart';

class AddInvoiceView extends GetView<AddInvoiceController> {
 


  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
  final InvoiceController invoiceController = Get.put(InvoiceController());
  final formKey = GlobalKey<FormState>();
  final TextEditingController searchUserController = TextEditingController();
  final TextEditingController selectUserId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(selectUserId.toString());
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
                    onPressed: () async {
                      await invoiceController.getInvoiceLists();
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
              'Add Invoice',
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Select User',
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
                        controller: searchUserController,
                        keyboardType: TextInputType.none,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Search user",
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
                        // validator: (value) {
                        //   if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!) ||
                        //       value.length < 3) {
                        //     return 'please enter valid Number';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        onTap: () {
                          Get.to(SearchUser(),
                              arguments:
                                  TextData(searchUserController, selectUserId));
                        },
                      ),
                      // Obx(() {
                      //   return DropdownButtonFormField(
                      //     isExpanded: true,
                      //     isDense: true,
                      //     style: GoogleFonts.roboto(
                      //         fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      //     decoration: InputDecoration(
                      //         hintStyle: GoogleFonts.roboto(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w300,
                      //           height: 1.1725,
                      //           color: Color.fromARGB(93, 0, 0, 0),
                      //         ),
                      //         hintText: "Select user",
                      //         contentPadding: const EdgeInsets.symmetric(
                      //             vertical: 18.0, horizontal: 18),
                      //         enabled: true,
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(16),
                      //             borderSide: BorderSide(
                      //                 width: 0,
                      //                 color:
                      //                     Color.fromARGB(255, 199, 199, 179))),
                      //         filled: true,
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 width: 0,
                      //                 color:
                      //                     Color.fromARGB(255, 255, 255, 255)),
                      //             borderRadius: BorderRadius.circular(16)),
                      //         fillColor: Color.fromARGB(153, 255, 255, 255),
                      //         focusColor: Color.fromARGB(255, 231, 231, 231)),
                      //     value: addInvoiceController.selectUserId,
                      //     onChanged: (value) {
                      //       addInvoiceController.changeUser(
                      //         value: value,
                      //       );
                      //     },
                      //     items:
                      //         addInvoiceController.userLists.value.map((data) {
                      //       return DropdownMenuItem(
                      //           value: data.id.toString(),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(bottom: 5.0),
                      //             child: Text(
                      //               data.phone,
                      //               overflow: TextOverflow.visible,
                      //             ),
                      //           ));
                      //     }).toList(),
                      //   );
                      // }),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Select Shop',
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
                        return DropdownButtonFormField(
                          isExpanded: true,
                          isDense: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                              hintText: "Select Shop",
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
                          value: addInvoiceController.selectShopId,
                          onChanged: (value) {
                            addInvoiceController.changeShop(
                              value: value,
                            );
                          },
                          items:
                              addInvoiceController.shopLists.value.map((data) {
                            return DropdownMenuItem(
                                value: data.id.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    data.name,
                                    overflow: TextOverflow.visible,
                                  ),
                                ));
                          }).toList(),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Invoice Image',
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
                      GetBuilder<AddInvoiceController>(builder: (scontext) {
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
                                    hintText:
                                        addInvoiceController.invoiceImg == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                    contentPadding: const EdgeInsets.symmetric(
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
                                // validator: (value) {
                                //   if (!RegExp(r'^-?[0-9]+$')
                                //           .hasMatch(value!) ||
                                //       value.length < 3) {
                                //     return 'please enter valid email';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                addInvoiceController.pickimage();
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
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Invoice Number',
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
                        controller: addInvoiceController.invoiceNumber,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter invoice number",
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
                          if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!) ||
                              value.length < 3) {
                            return 'please enter valid Number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Invoice Date',
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
                        controller: addInvoiceController.invoiceDAte,
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
                            suffixIcon: Icon(Icons.calendar_month),
                            hintText: "Enter Date",
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
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xe53f46bd),
                                    ).copyWith(secondary: Colors.pink),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            addInvoiceController.invoiceDAte.text =
                                formattedDate;
                          } else {
                            var newdate = DateTime.now();
                            var newFormat =
                                DateFormat('yyyy-MM-dd').format(newdate);
                            addInvoiceController.invoiceDAte.text = newFormat;
                          }
                          return;
                        },
                        // validator: (value) {
                        //   if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!) ||
                        //       value.length < 3) {
                        //     return 'please enter valid name';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Pre Tax Amount',
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
                        controller: addInvoiceController.preTaxController,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "0",
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
                          if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!) ||
                              value.isEmpty) {
                            return 'please enter valid Amount';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Invoice Amount',
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
                        controller:
                            addInvoiceController.invoiceAmountController,
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
                            hintText: "0",
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
                          if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!) ||
                              value.isEmpty) {
                            return 'please enter valid Amount';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Remarks',
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
                        controller: addInvoiceController.remarksController,
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
                            hintText: "Type here..",
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
                          if (value!.isEmpty) {
                            return 'please enter remarks';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
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
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: addInvoiceController
                                                  .isLoading.value ==
                                              true
                                          ? null
                                          : () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                addInvoiceController.addInvoice(
                                                    context: context,
                                                    customerid: int.tryParse(
                                                        selectUserId.text));
                                              }
                                            },
                                      icon: addInvoiceController
                                                  .isLoading.value ==
                                              true
                                          ? CircularProgressIndicator()
                                          : Icon(Icons.save),
                                      label: Text(addInvoiceController
                                                  .isLoading.value ==
                                              true
                                          ? "Processing"
                                          : "Save")),
                                );
                              })),
                        ],
                      ),
                      SizedBox(
                        height: 30,
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

class TextData {
  final TextEditingController number;
  final TextEditingController id;

  TextData(this.number, this.id);
}
