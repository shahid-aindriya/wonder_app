import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/colors.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/invoice_data.dart';

import '../controllers/invoice_details_controller.dart';

class InvoiceDetailsView extends GetView<InvoiceDetailsController> {
  final InvoiceDatum? data;
  final AmountData? amountdataList;
  final InvoiceController? invoiceController;
  InvoiceDetailsView({this.data, this.amountdataList, this.invoiceController});

  final InvoiceDetailsController invoiceDetailsController =
      Get.put(InvoiceDetailsController());
  @override
  Widget build(BuildContext context) {
    invoiceDetailsController.shopId = data!.shopId;
    invoiceDetailsController.amount = data!.amountData.additionalAmount;
    invoiceDetailsController.invoiceId = data!.id;
    String formattedDate = DateFormat("dd MMMM, yyyy")
        .format(DateTime.parse(data!.invoiceDate.toString()));
    log(data!.invoiceDate.toString());
    String formattedDate2 = DateFormat("dd MMM yyyy")
        .format(DateTime.parse(data!.invoiceDate.toString()).toLocal());
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //     backgroundColor: Color.fromARGB(255, 77, 96, 221),
          //     onPressed: () async {},
          //     child: Icon(Icons.download)),
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
            centerTitle: true,
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invoice Approval Request",
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            formattedDate2,
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Figma Flutter Generator Rectangle17Widget - RECTANGLE
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                            begin: Alignment(
                                1.1437236070632935, -0.005003529135137796),
                            end: Alignment(
                                -0.06076670065522194, 0.042849887162446976),
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0.75),
                              Color.fromRGBO(255, 255, 255, 0.3199999928474426)
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Invoice Amount of",
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 229, 223, 227)),
                                      width: 146,
                                      height: 64,
                                      child: Center(
                                        child: AutoSizeText(
                                          "₹${data!.invoiceAmount}",
                                          maxLines: 2,
                                          minFontSize: 25,
                                          maxFontSize: 31,
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 117, 231),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 99,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Invoice Number",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(data!.invoiceNumber,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Invoice Date",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    AutoSizeText(formattedDate,
                                        maxLines: 2,
                                        minFontSize: 14,
                                        maxFontSize: 20,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount Details",
                                  style: GoogleFonts.roboto(
                                      color: Color.fromARGB(155, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Current Amount -",
                                        style: GoogleFonts.roboto(
                                            color: Color.fromARGB(155, 0, 0, 0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                          data != null
                                              ? "₹ ${data!.amountData.currentAmount}"
                                              : "₹0",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 117, 231),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Commission Amount - ",
                                        style: GoogleFonts.roboto(
                                            color: Color.fromARGB(155, 0, 0, 0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                          data != null
                                              ? "₹ ${data!.amountData.commissionAmount}"
                                              : "₹0",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 117, 231),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Additional Amount - ",
                                        style: GoogleFonts.roboto(
                                            color: Color.fromARGB(155, 0, 0, 0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      width: 9.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                          data != null
                                              ? "₹ ${data!.amountData.additionalAmount}"
                                              : "₹0",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 117, 231),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Requested By",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            ListTile(
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: data!.userImage == ''
                                        ? Image.asset("assets/images/User.png")
                                        : Image.network(
                                            "$baseUrlForImage${data!.userImage}")),
                                title: Text(data!.customerName!,
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  data!.phone.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    invoiceDetailsController
                                        .makePhoneCall(data!.phone);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/call.png",
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: data!.status == "Pending" ? true : false,
                        child: ApproveAndDecline(
                            invoiceController: invoiceController,
                            invoiceDetailsController: invoiceDetailsController,
                            data: data)),

                    Obx(() {
                      return Visibility(
                        visible:
                            invoiceDetailsController.isLoading.value == false
                                ? false
                                : true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        Size(44.w, 53)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 162, 173, 163)))),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(134, 255, 255, 255))),
                                onPressed: null,
                                icon: CircularProgressIndicator(),
                                label: Text("Processing",
                                    style: GoogleFonts.roboto(
                                        color:
                                            Color.fromARGB(255, 99, 104, 100),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      );
                    }),

                    Visibility(
                      visible: data!.status == "Pending" ? false : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize:
                                      MaterialStateProperty.all(Size(60.w, 53)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          side: BorderSide(color: greyColor))),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(134, 255, 255, 255))),
                              onPressed: null,
                              child: Text(
                                  data!.status == "Reject"
                                      ? "Rejected"
                                      : "Approved",
                                  style: GoogleFonts.roboto(
                                      color: greyColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                    Text("Invoice Copy",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Container(
                          width: 100.w,
                          child: data!.invoiceImage == ""
                              ? Image.asset("assets/images/invoice_image.png")
                              : Image.network(
                                  "$baseUrlForImage${data!.invoiceImage}")),
                    )

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height,
                    //     width: 100.w,
                    //     child: PhotoView(
                    //         imageProvider:
                    //             AssetImage('assets/images/invoice_image.png'),
                    //         minScale: PhotoViewComputedScale.contained * 0),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ApproveAndDecline extends StatelessWidget {
  const ApproveAndDecline(
      {super.key,
      required this.invoiceDetailsController,
      required this.data,
      this.invoiceController});
  final InvoiceController? invoiceController;
  final InvoiceDetailsController invoiceDetailsController;
  final InvoiceDatum? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return Visibility(
            visible: invoiceDetailsController.isLoading.value == false
                ? true
                : false,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(44.w, 53)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(
                            color: Color.fromARGB(255, 0, 158, 16)))),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(134, 255, 255, 255))),
                onPressed: data!.amountData.additionalAmount > 0
                    ? () {
                        invoiceDetailsController.openCheckout(
                            email: data!.amountData.email,
                            name: data!.amountData.name,
                            amount: data!.amountData.additionalAmount + 00,
                            razorKey: data!.amountData.razorKey,
                            invoiceId: data!.id);

                        // invoiceDetailsController.openCheckout(
                        //     invoiceId: data!.id,
                        //     amount: data!.amountData.additionalAmount + 00,
                        //     razorKey: data!.amountData.razorKey);
                      }
                    : () async {
                        await invoiceDetailsController.approveOrDeclineInvoice(
                            inoviceController: invoiceController,
                            context: context,
                            choice: "Approve",
                            invoiceId: data!.id);
                      },
                icon: Icon(Icons.check, color: Color.fromARGB(255, 0, 158, 16)),
                label: Text(
                    data!.amountData.additionalAmount > 0
                        ? "Pay & Approve"
                        : "Approve",
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 0, 158, 16),
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
          );
        }),
        Obx(() {
          return Visibility(
            visible: invoiceDetailsController.isLoading.value == false
                ? true
                : false,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(44.w, 53)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(
                            color: Color.fromARGB(255, 255, 80, 80)))),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(134, 255, 255, 255))),
                onPressed: () async {
                  await invoiceDetailsController.approveOrDeclineInvoice(
                      inoviceController: invoiceController,
                      context: context,
                      choice: "Reject",
                      invoiceId: data!.id);
                },
                icon:
                    Icon(Icons.close, color: Color.fromARGB(255, 255, 80, 80)),
                label: Text("Decline",
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 255, 80, 80),
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
          );
        }),
      ],
    );
  }
}
