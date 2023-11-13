import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/taxes_controller.dart';

class GstView extends StatelessWidget {
  const GstView({
    super.key,
    required this.taxesController,
  });
  final TaxesController taxesController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 5.w),
          child: Row(
            children: [
              Text("GST",
                  style: GoogleFonts.jost(
                      fontSize: 18, color: Color.fromARGB(255, 73, 86, 178))),
            ],
          ),
        ),
        FutureBuilder(
            future: taxesController.getGst(),
            builder: (context, snapshot) {
              return Expanded(
                child: Obx(() {
                  return ListView.builder(
                      controller: taxesController.gstScrollController,
                      itemCount: taxesController.isGstLoading.value
                          ? taxesController.gstList.length + 1
                          : taxesController.gstList.length,
                      itemBuilder: (context, index1) {
                        if (index1 < taxesController.gstList.length) {
                          final data = taxesController.gstList[index1];
                          String formattedDate = DateFormat("h:mm a | MMM d")
                              .format(data.createdAt);
                          return Padding(
                            padding:
                                EdgeInsets.only(top: 15, right: 5.w, left: 5.w),
                            child: Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                    begin: Alignment(1.4153012037277222,
                                        0.15562866628170013),
                                    end: Alignment(-0.15562868118286133,
                                        0.044075123965740204),
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 0.75),
                                      Color.fromRGBO(
                                          255, 255, 255, 0.6800000071525574)
                                    ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ListTile(
                                  isThreeLine: false,
                                  title: Text(
                                      "Order#${data.orderNumber.toString()}",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            "Total Amount:",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text("  ₹${data.orderAmount}",
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 73, 86, 178),
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            "GST Amount:",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text("   ₹${data.tdsAmount}",
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 73, 86, 178),
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 94, 92, 92)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.amountType,
                                        style: GoogleFonts.roboto(
                                            color: Color.fromARGB(
                                                255, 73, 86, 178)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          );
                        }
                      });
                }),
              );
            })
      ],
    );
  }
}
