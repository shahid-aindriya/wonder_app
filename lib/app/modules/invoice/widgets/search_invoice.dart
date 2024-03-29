import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice_details/views/invoice_details_view.dart';

import '../../../data/colors.dart';

class SearchInvoice extends StatelessWidget {
  final InvoiceController invoiceController;
  SearchInvoice({super.key, required this.invoiceController});
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wonder_app_background.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                child: TextFormField(
                  controller: searchController,
                  focusNode: focusNode,
                  enabled: true,
                  keyboardType: TextInputType.number,
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
                          onTap: () {},
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
                    invoiceController.searchInvoiceResults(value);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Expanded(
                    child: ListView.builder(
                  itemCount: invoiceController.searchInvoiceList.length,
                  itemBuilder: (context, index) {
                    var datas = invoiceController.searchInvoiceList[index];

                    String formattedDate = DateFormat("MMM dd, yyyy")
                        .format(DateTime.parse(datas.invoiceDate.toString()));
                    // log(formattedDate);
                    if (datas.invoiceNumber.contains(searchController.text)) {
                      return InkWell(
                        onTap: () async {
                          // await invoiceController.invoiceDetails(
                          //     invoiceId: datas.id);
                          Get.off(InvoiceDetailsView(
                            data: datas,
                          ));
                        },
                        child: Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: const ValueKey(0),

                          // The start action pane is the one at the left or the top side.
                          endActionPane: ActionPane(
                            extentRatio: .4,
                            dragDismissible: false,
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.

                            // All actions are defined in the children parameter.
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 70,
                                  width: 54,
                                  child: Image.asset(
                                    "assets/images/approve.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 70,
                                  width: 54,
                                  child: Image.asset(
                                    "assets/images/decline.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 100.w,
                              height: 80,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                  bottomLeft: Radius.circular(14),
                                  bottomRight: Radius.circular(14),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment(1.1437236070632935,
                                        -0.005003529135137796),
                                    end: Alignment(-0.06076670065522194,
                                        0.042849887162446976),
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 0.75),
                                      Color.fromRGBO(
                                          255, 255, 255, 0.3199999928474426)
                                    ]),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0, left: 10),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: datas.status == "Pending"
                                              ? Color.fromARGB(
                                                  255, 144, 149, 255)
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
                                              "₹${datas.invoiceAmount}",
                                              maxFontSize: 18,
                                              minFontSize: 12,
                                              style: GoogleFonts.roboto(
                                                  color:
                                                      datas.status == "Pending"
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
                                                color: datas.status == "Pending"
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
                                          padding: EdgeInsets.only(
                                              top: 14.0, left: 2.w),
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
                                                                  "Pending"
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
                                                                  "Pending"
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
                                                              "Pending"
                                                          ? Colors.black
                                                          : greyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300))
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
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ));
              })
            ],
          ),
        ));
  }
}
