import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/invoice_controller.dart';
import '../views/invoice_view.dart';

class Due extends GetView<InvoiceController> {
  const Due({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: invoiceController.getDueData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: invoiceController.selectShopId == null
                ? () async {}
                : () async {
                    invoiceController.dueCurrentCount.value = 1;
                    invoiceController.dueList.clear();
                    invoiceController.shopWalletAmount.value = "0";
                    invoiceController.getDueData();
                  },
            child: ListView(
              controller: invoiceController.dueScrollController,
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Payable to Wonder Points/Users",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Color.fromARGB(255, 74, 74, 74)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 77, 96, 221), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() => Text(
                                      invoiceController.shopWalletAmount.value
                                          .toString(),
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          color:
                                              Color.fromARGB(255, 77, 96, 221),
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    "assets/images/gold.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 40,
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
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: () async {},
                                child: Text("Pay")))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100.w,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, .5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("assets/images/transact.png"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Transactions",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 77, 96, 221)),
                      )
                    ],
                  ),
                ),
                Obx(() {
                  return invoiceController.dueList.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                      "assets/images/13659-no-data.json"),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Obx(() {
                          return ListView.builder(
                            itemCount: invoiceController.isDueLoading.value
                                ? invoiceController.dueList.length + 1
                                : invoiceController.dueList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < invoiceController.dueList.length) {
                                final data = invoiceController.dueList[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 15, right: 5.w, left: 5.w),
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
                                            Color.fromRGBO(255, 255, 255,
                                                0.6800000071525574)
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ListTile(
                                        isThreeLine: false,
                                        title: Text("Due Amount",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        subtitle: Text(
                                          "${data['created_at']}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        trailing: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data['entry_type'] != "Credit"
                                                  ? "+${data['amount']}"
                                                  : "-${data['amount']}",
                                              style: GoogleFonts.roboto(
                                                  color: data['entry_type'] !=
                                                          "Credit"
                                                      ? Colors.green
                                                      : Color.fromARGB(
                                                          255, 243, 106, 106),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600),
                                            ),
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
                            },
                          );
                        });
                })
              ],
            ),
          );
        });
  }
}
