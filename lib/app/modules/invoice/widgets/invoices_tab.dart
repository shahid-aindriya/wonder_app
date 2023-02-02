import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice_details/views/invoice_details_view.dart';

class InvoiceTab extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  InvoiceTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await invoiceController.getInvoiceLists();
      },
      child: FutureBuilder(
        future: invoiceController.getInvoiceLists(),
        builder: (context, snapshot) {
          return Obx(() {
            return invoiceController.invoiceLists.value.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/images/13659-no-data.json"),
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: invoiceController.invoiceLists.value.length,
                    itemBuilder: (context, index) {
                      var datas = invoiceController.invoiceLists.value[index];
                      String formattedDate = DateFormat("MMM dd, yyyy")
                          .format(DateTime.parse(datas.invoiceDate.toString()));
                      // log(formattedDate);
                      return InkWell(
                        onTap: () {
                          Get.to(InvoiceDetailsView(
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
                                        top: 3.0, left: 15),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 144, 149, 255)),
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
                                              minFontSize: 16,
                                              style: GoogleFonts.roboto(
                                                  color: Color.fromARGB(
                                                      255, 73, 117, 231),
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
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
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
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                    TextSpan(
                                                      text: datas.customerName,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          color: Colors.black,
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
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8,
                                                left: 2,
                                                right: 2),
                                            child: Image.asset(
                                                "assets/images/invoice_frame.png"),
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
                    },
                  );
          });
        },
      ),
    );
  }
}
