import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';

import '../../../data/colors.dart';
import '../../invoice_details/views/invoice_details_view.dart';

class SearchInvoice extends GetView<InvoiceController> {
  final InvoiceController invoiceController;
  SearchInvoice({super.key, required this.invoiceController});

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
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
            invoiceController.searchInvoiceController.clear();
            Get.back();
            throw Exception();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(117, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        // invoiceController.searchInvoiceLists.clear();
                        // invoiceController.currentPage.value = 1;
                        invoiceController.searchInvoiceController.clear();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xff4956b2),
                      )),
                ),
              ),
              title: Column(
                children: [
                  TextFormField(
                    controller: invoiceController.searchInvoiceController,
                    focusNode: focusNode,
                    enabled: true,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, .6)),
                        hintText: "Search Invoice Here...",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 20),
                        enabled: true,
                        suffixIcon: InkWell(
                            onTap: () {
                              // invoiceController.currentPage.value = 1;
                              // invoiceController.search(
                              //     invoiceController.searchInvoiceController.text);
                              invoiceController.page.value = 1;
                              invoiceController.fetchData();
                            },
                            child: Image.asset("assets/images/search.png")),
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
                        fillColor: Color.fromARGB(92, 255, 255, 255),
                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                    onChanged: (value) {
                      invoiceController.page.value = 1;
                      invoiceController.fetchData();
                    },
                  ),
                  Text(
                    '''NB: Please search date in this "eg: 2023-03-29" format ''',
                    style: GoogleFonts.roboto(
                        fontSize: 10, color: Color.fromARGB(255, 50, 50, 50)),
                  ),
                ],
              ),
            ),
            body: Obx(() {
              return ListView.builder(
                controller: invoiceController.scrollController,
                shrinkWrap: true,
                itemCount: invoiceController.isFetching.value
                    ? invoiceController.searchInvoiceLists.length + 1
                    : invoiceController.searchInvoiceLists.length,
                itemBuilder: (context, index) {
                  if (index < invoiceController.searchInvoiceLists.length) {
                    var datas = invoiceController.searchInvoiceLists[index];
                    String formattedDate = DateFormat("MMM dd, yyyy")
                        .format(DateTime.parse(datas.invoiceDate.toString()));
                    return InkWell(
                      onTap: () async {
                        // await invoiceController.invoiceDetails(
                        //     invoiceId: datas.id);
                        Get.to(InvoiceDetailsView(
                          id: datas.id,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 100.w,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment(
                                    1.1437236070632935, -0.005003529135137796),
                                end: Alignment(
                                    -0.06076670065522194, 0.042849887162446976),
                                colors: [
                                  Color.fromRGBO(255, 255, 255, 0.75),
                                  Color.fromRGBO(
                                      255, 255, 255, 0.3199999928474426)
                                ]),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 10),
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (datas.status == "Pending" ||
                                              datas.status == "Verified")
                                          ? Color.fromARGB(255, 144, 149, 255)
                                          : greyColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 229, 223, 227)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          maxLines: 2,
                                          "₹${datas.preTaxAmount}",
                                          maxFontSize: 18,
                                          minFontSize: 12,
                                          style: GoogleFonts.roboto(
                                              color: datas.status ==
                                                          "Pending" ||
                                                      datas.status == "Verified"
                                                  ? Color.fromARGB(
                                                      255, 73, 117, 231)
                                                  : greyColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Text(
                                        formattedDate,
                                        style: GoogleFonts.roboto(
                                            color: datas.status == "Pending" ||
                                                    datas.status == "Verified"
                                                ? Colors.black
                                                : greyColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 14.0, left: 2.w),
                                      child: Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'By ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      color: datas.status ==
                                                                  "Pending" ||
                                                              datas.status ==
                                                                  "Verified"
                                                          ? Colors.black
                                                          : greyColor,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                TextSpan(
                                                  text: datas.phone,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      color: datas.status ==
                                                                  "Pending" ||
                                                              datas.status ==
                                                                  "Verified"
                                                          ? Colors.black
                                                          : greyColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                              " Invoice No: ${datas.invoiceNumber}",
                                              style: GoogleFonts.roboto(
                                                  color: datas.status ==
                                                              "Pending" ||
                                                          datas.status ==
                                                              "Verified"
                                                      ? Colors.black
                                                      : greyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3.0,
                                              bottom: 3,
                                              left: 4,
                                              right: 4),
                                          child: SvgPicture.asset(datas
                                                      .status ==
                                                  "Pending"
                                              ? "assets/images/pending.svg"
                                              : datas.status == "Reject"
                                                  ? "assets/images/rejected.svg"
                                                  : datas.status == "Verified"
                                                      ? "assets/images/verified.svg"
                                                      : "assets/images/aporved.svg"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (invoiceController.searchInvoiceLists.isEmpty) {
                    return Text("No data found");
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                },
              );
            }),
          ),
        ));
  }
}
