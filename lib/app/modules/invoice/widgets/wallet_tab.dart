import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/request_coins/views/request_coins_view.dart';

class WalletTab extends StatelessWidget {
  final InvoiceController invoiceController;

  WalletTab({
    required this.invoiceController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await invoiceController.onPullRefreshInWallet();
      },
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment(6.123234262925839e-17, 1),
                      end: Alignment(-1, 6.123234262925839e-17),
                      colors: [
                        Color.fromRGBO(57, 55, 166, 1),
                        Color.fromRGBO(65, 114, 222, 1)
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 26, right: 26, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Text(
                          "Total Balance",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                invoiceController.walletAmount.value == ''
                                    ? '0'
                                    : invoiceController.walletAmount.value,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.roboto(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    "assets/images/gold.png",
                                    fit: BoxFit.contain,
                                  )),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 15),
            child: ElevatedButton(
                onPressed: () {
                  Get.to(RequestCoinsView());
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                    elevation: MaterialStateProperty.all(12),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text(
                  "Request coins",
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 63, 72, 191)),
                )),
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
            return invoiceController.walletTransactionLists.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 2.h,
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
                : Expanded(
                    child: ListView.builder(
                        itemCount:
                            invoiceController.walletTransactionLists.length,
                        itemBuilder: (context, index) {
                          var data =
                              invoiceController.walletTransactionLists[index];
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
                                  leading: Image.asset(
                                      "assets/images/invoice_frame.png"),
                                  title: Text(
                                      invoiceController
                                          .walletTransactionLists[index].phone,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(
                                    data.entryType,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (data.amount == "0" ||
                                                data.entryType == 'Credit')
                                            ? "+${data.amount}"
                                            : "-${data.amount}",
                                        style: GoogleFonts.roboto(
                                            color: data.entryType == "Debit"
                                                ? Color.fromARGB(
                                                    255, 243, 106, 106)
                                                : Colors.green,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // Text("2 Minutes Ago",
                                      //     style: GoogleFonts.roboto(
                                      //         fontSize: 10,
                                      //         fontWeight: FontWeight.w300))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
          })
        ],
      ),
    );
  }
}
