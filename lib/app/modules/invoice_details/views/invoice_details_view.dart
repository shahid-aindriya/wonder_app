import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/colors.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice_details/models/invoice_details_response.dart';

import '../../invoice/views/invoice_view.dart';
import '../controllers/invoice_details_controller.dart';
import '../widgets/view_image.dart';

class InvoiceDetailsView extends GetView<InvoiceDetailsController> {
  final id;

  InvoiceDetailsView({this.id});

  final InvoiceDetailsController invoiceDetailsController =
      Get.put(InvoiceDetailsController());
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
      child: Obx(() {
        return WillPopScope(
          onWillPop: invoiceDetailsController.isButtonLoad.value == true ||
                  invoiceDetailsController.isLoading.value == true
              ? null
              : () {
                  Get.back();
                  throw Exception();
                },
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
                    child: Obx(() {
                      return IconButton(
                          onPressed: invoiceDetailsController
                                          .isButtonLoad.value ==
                                      true ||
                                  invoiceDetailsController.isLoading.value ==
                                      true
                              ? null
                              : () {
                                  Get.back();
                                },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xff4956b2),
                          ));
                    }),
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
                  FutureBuilder(
                      future: invoiceDetailsController.getInvoiceDetails(
                          invoiceId: id),
                      builder: (contexts, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 40.h),
                              CircularProgressIndicator(),
                              Text("   Please Stay on the screen")
                            ],
                          );
                        }

                        return Obx(() {
                          return invoiceDetailsController
                                  .invoiceDetailsList.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              "assets/images/13659-no-data.json"),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: 1,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (contextsd, index) {
                                    var newData = invoiceDetailsController
                                        .invoiceDetailsList[index];
                                    invoiceDetailsController.shopId =
                                        newData.invoiceData.shopId;
                                    invoiceDetailsController.amount =
                                        newData.amountData.additionalAmount;
                                    invoiceDetailsController.invoiceId =
                                        newData.invoiceData.id;
                                    String formattedDate =
                                        DateFormat("dd MMMM, yyyy").format(
                                            DateTime.parse(newData
                                                .invoiceData.invoiceDate
                                                .toString()));
                                    String formattedDate2 =
                                        DateFormat("dd MMM yyyy").format(
                                            DateTime.parse(newData
                                                    .invoiceData.invoiceDate
                                                    .toString())
                                                .toLocal());
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Invoice Approval Request",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  formattedDate2,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              gradient: LinearGradient(
                                                  begin: Alignment(
                                                      1.1437236070632935,
                                                      -0.005003529135137796),
                                                  end: Alignment(
                                                      -0.06076670065522194,
                                                      0.042849887162446976),
                                                  colors: [
                                                    Color.fromRGBO(
                                                        255, 255, 255, 0.75),
                                                    Color.fromRGBO(255, 255,
                                                        255, 0.3199999928474426)
                                                  ]),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30.0, left: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Invoice Amount of",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        229,
                                                                        223,
                                                                        227)),
                                                            width: 146,
                                                            height: 64,
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                "₹${newData.invoiceData.preTaxAmount}",
                                                                maxLines: 2,
                                                                minFontSize: 25,
                                                                maxFontSize: 31,
                                                                style: GoogleFonts.roboto(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            73,
                                                                            117,
                                                                            231),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(() {
                                                            return TextButton(
                                                                onPressed: (invoiceDetailsController.invoiceDetailsList[index].invoiceData.status ==
                                                                            "Approve" ||
                                                                        invoiceDetailsController.invoiceDetailsList[index].invoiceData.status ==
                                                                            "Reject")
                                                                    ? null
                                                                    : () {
                                                                        invoiceDetailsController.showPopupTax(
                                                                            context:
                                                                                context,
                                                                            id: newData
                                                                                .invoiceData.id,
                                                                            date:
                                                                                newData.invoiceData.invoiceDate,
                                                                            amount: newData.invoiceData.preTaxAmount,
                                                                            invoiceNumber: newData.invoiceData.invoiceNumber);
                                                                      },
                                                                child: Text(
                                                                  "Edit",
                                                                  style: GoogleFonts.roboto(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline),
                                                                ));
                                                          })
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
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Invoice Number",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                            Text(
                                                                newData
                                                                    .invoiceData
                                                                    .invoiceNumber
                                                                    .toString(),
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                            Text(
                                                              "Invoice Date",
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                            AutoSizeText(
                                                                formattedDate,
                                                                maxLines: 2,
                                                                minFontSize: 14,
                                                                maxFontSize: 20,
                                                                style: GoogleFonts.roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
                                                    child: Divider(
                                                      thickness: 2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Amount Details",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Color
                                                                    .fromARGB(
                                                                        155,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Current Amount -",
                                                              style: GoogleFonts.roboto(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          155,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                          SizedBox(
                                                            width: 14.w,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                newData.amountData
                                                                            .currentAmount !=
                                                                        null
                                                                    ? "₹ ${newData.amountData.currentAmount}"
                                                                    : "₹0",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.roboto(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            73,
                                                                            117,
                                                                            231),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Commission Amount - ",
                                                              style: GoogleFonts.roboto(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          155,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                newData.amountData
                                                                            .commissionAmount !=
                                                                        null
                                                                    ? "₹ ${newData.amountData.commissionAmount}"
                                                                    : "₹0",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.roboto(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            73,
                                                                            117,
                                                                            231),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Additional Amount - ",
                                                              style: GoogleFonts.roboto(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          155,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300)),
                                                          SizedBox(
                                                            width: 9.w,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                                newData.amountData
                                                                            .additionalAmount !=
                                                                        null
                                                                    ? "₹ ${newData.amountData.additionalAmount}"
                                                                    : "₹0",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.roboto(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            73,
                                                                            117,
                                                                            231),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
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
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                    ],
                                                  ),
                                                  ListTile(
                                                      leading: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: newData
                                                                      .invoiceData
                                                                      .userImage ==
                                                                  ''
                                                              ? Image.asset(
                                                                  "assets/images/User.png")
                                                              : Image.network(
                                                                  "$baseUrlForImage${newData.invoiceData.userImage}")),
                                                      title: Text(
                                                          newData.invoiceData
                                                              .customerName
                                                              .toString(),
                                                          style: GoogleFonts.roboto(
                                                              fontSize: 18,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500)),
                                                      subtitle: Text(
                                                        newData
                                                            .invoiceData.phone
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                      trailing: InkWell(
                                                        onTap: () {
                                                          invoiceDetailsController
                                                              .makePhoneCall(
                                                                  newData
                                                                      .invoiceData
                                                                      .phone);
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
                                          Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                gradient: LinearGradient(
                                                    begin: Alignment(
                                                        1.1437236070632935,
                                                        -0.005003529135137796),
                                                    end: Alignment(
                                                        -0.06076670065522194,
                                                        0.042849887162446976),
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 0.75),
                                                      Color.fromRGBO(
                                                          255,
                                                          255,
                                                          255,
                                                          0.3199999928474426)
                                                    ]),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Remarks:",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            20.0),
                                                                child: Text(newData
                                                                    .invoiceData
                                                                    .remark),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                              visible:
                                                  (newData.invoiceData.status ==
                                                          "Verified")
                                                      ? true
                                                      : false,
                                              child: ApproveAndDecline(
                                                  invoiceController:
                                                      invoiceController,
                                                  invoiceDetailsController:
                                                      invoiceDetailsController,
                                                  data: newData)),

                                          Obx(() {
                                            return Visibility(
                                              visible: invoiceDetailsController
                                                              .invoiceDetailsList[
                                                                  index]
                                                              .invoiceData
                                                              .status ==
                                                          "Verified" ||
                                                      invoiceDetailsController
                                                              .invoiceDetailsList[
                                                                  index]
                                                              .invoiceData
                                                              .status ==
                                                          "Approve" ||
                                                      invoiceDetailsController
                                                              .invoiceDetailsList[
                                                                  index]
                                                              .invoiceData
                                                              .status ==
                                                          "Reject" ||
                                                      invoiceDetailsController
                                                              .isLoading
                                                              .value ==
                                                          true
                                                  ? false
                                                  : true,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(() {
                                                    return ElevatedButton.icon(
                                                        style: ButtonStyle(
                                                            fixedSize: MaterialStateProperty.all(
                                                                Size(44.w, 53)),
                                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        7),
                                                                side: BorderSide(
                                                                    color: Color.fromARGB(
                                                                        255,
                                                                        0,
                                                                        158,
                                                                        16)))),
                                                            elevation:
                                                                MaterialStateProperty.all(
                                                                    0),
                                                            backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    Color.fromARGB(134, 255, 255, 255))),
                                                        onPressed: invoiceDetailsController.isButtonLoad.value == true
                                                            ? null
                                                            : () {
                                                                invoiceDetailsController.approveOrDeclineInvoice(
                                                                    choice:
                                                                        "Verified",
                                                                    context:
                                                                        context,
                                                                    inoviceController:
                                                                        invoiceController,
                                                                    invoiceId:
                                                                        newData
                                                                            .invoiceData
                                                                            .id);
                                                              },
                                                        icon: invoiceDetailsController.isButtonLoad.value == false
                                                            ? Icon(Icons.verified_outlined, color: Color.fromARGB(255, 0, 158, 16))
                                                            : CircularProgressIndicator(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        158,
                                                                        16),
                                                              ),
                                                        label: Text(invoiceDetailsController.isButtonLoad.value == true ? "Processing" : "Please Verify", style: GoogleFonts.roboto(color: Color.fromARGB(255, 0, 158, 16), fontSize: 16, fontWeight: FontWeight.w500)));
                                                  }),
                                                ],
                                              ),
                                            );
                                          }),

                                          Obx(() {
                                            return Visibility(
                                              visible: invoiceDetailsController
                                                          .isLoading.value ==
                                                      false
                                                  ? false
                                                  : true,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                          fixedSize: MaterialStateProperty.all(
                                                              Size(44.w, 53)),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          7),
                                                                  side: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          162,
                                                                          173,
                                                                          163)))),
                                                          elevation:
                                                              MaterialStateProperty.all(
                                                                  0),
                                                          backgroundColor:
                                                              MaterialStateProperty.all(Color.fromARGB(134, 255, 255, 255))),
                                                      onPressed: null,
                                                      icon: CircularProgressIndicator(),
                                                      label: Text("Stay on the screen", style: GoogleFonts.roboto(color: Color.fromARGB(255, 99, 104, 100), fontSize: 16, fontWeight: FontWeight.w500))),
                                                ],
                                              ),
                                            );
                                          }),

                                          Visibility(
                                            visible:
                                                (newData.invoiceData.status ==
                                                            "Pending" ||
                                                        newData.invoiceData
                                                                .status ==
                                                            "Verified")
                                                    ? false
                                                    : true,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        fixedSize:
                                                            MaterialStateProperty.all(
                                                                Size(60.w, 53)),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        7),
                                                                side: BorderSide(
                                                                    color:
                                                                        greyColor))),
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(0),
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                Color.fromARGB(134, 255, 255, 255))),
                                                    onPressed: null,
                                                    child: Text(newData.invoiceData.status == "Reject" ? "Rejected" : "Approved", style: GoogleFonts.roboto(color: greyColor, fontSize: 16, fontWeight: FontWeight.w500))),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
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
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 20),
                                            child: Container(
                                                width: 100.w,
                                                child: newData.invoiceData
                                                            .invoiceImage ==
                                                        ""
                                                    ? Image.asset(
                                                        "assets/images/invoice_image.png")
                                                    : InkWell(
                                                        onTap: () {
                                                          Get.to(ViewImage(
                                                            imageUrl: newData
                                                                .invoiceData
                                                                .invoiceImage,
                                                          ));
                                                        },
                                                        child: Image.network(
                                                            "$baseUrlForImage${newData.invoiceData.invoiceImage}"),
                                                      )),
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
                                    );
                                  });
                        });
                      })
                ],
              )),
        );
      }),
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
  final InvoiceDetailsResponse data;

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
                onPressed: data.amountData.additionalAmount > 0
                    ? () {
                        invoiceDetailsController.openCheckout(
                            data: data,
                            email: data.amountData.email,
                            name: data.amountData.name,
                            amount: data.amountData.additionalAmount,
                            razorKey: data.amountData.razorKey,
                            invoiceId: data.invoiceData.id);

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
                            invoiceId: data.invoiceData.id);
                      },
                icon: Icon(Icons.check, color: Color.fromARGB(255, 0, 158, 16)),
                label: Text(
                    data.amountData.additionalAmount > 0
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
                  await invoiceDetailsController.deletePopup(
                      context: context, invoiceId: data.invoiceData.id);
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
