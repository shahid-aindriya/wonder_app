import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/widgets/search_wallet_data.dart';
import 'package:wonder_app/app/modules/request_coins/views/request_coins_view.dart';

import '../views/invoice_view.dart';

class WalletTab extends GetView<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: invoiceController.selectShopId == null
          ? () async {}
          : () async {
              invoiceController.walletCurrentpage.value = 1;
              invoiceController.walletAmount.value = "";
              invoiceController.walletTransactionLists.clear();
              invoiceController
                  .onDropDownChanged(invoiceController.selectShopId);
            },
      child: ListView(
        controller: (invoiceController.startDate == null &&
                invoiceController.endDate == null)
            ? invoiceController.walletTransactionScrollController
            : invoiceController.dateRangeScrollController,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => Text(
                                invoiceController.walletAmount.value == ''
                                    ? '0'
                                    : invoiceController.walletAmount.value,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.to(RequestCoinsView());
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7))),
                        elevation: MaterialStateProperty.all(12),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      "Request coins",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 63, 72, 191)),
                    )),
              ],
            ),
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
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                        SearchWalletData(invoiceController: invoiceController));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(117, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.asset("assets/images/search.png"),
                          // Text(
                          //   "  Search",
                          //   style: GoogleFonts.roboto(
                          //       color: Color.fromARGB(117, 114, 109, 109)),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      height: 40,
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, .6)),
                            hintText: "Select",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
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
                            fillColor: Color.fromARGB(92, 255, 255, 255),
                            focusColor: Color.fromARGB(255, 231, 231, 231)),
                        value: invoiceController.debitListValue.value,
                        onChanged: (value) async {
                          invoiceController.debitListValue.value =
                              value.toString();
                          invoiceController.currentDatePage.value = 1;
                          invoiceController.walletCurrentpage.value = 1;
                          invoiceController.onDropDownChanged(
                              invoiceController.selectShopId);
                        },
                        items: invoiceController.debitList.map((data) {
                          return DropdownMenuItem(
                              value: data,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  data,
                                  overflow: TextOverflow.visible,
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(117, 255, 255, 255))),
                    onPressed: () async {
                      invoiceController.currentDatePage.value = 1;
                      invoiceController.dateSelect(context: context);
                    },
                    child: Obx(() {
                      return Text(
                        invoiceController.endDateString.isEmpty &&
                                invoiceController.endDateString.isEmpty
                            ? "Select Date Range"
                            : "${invoiceController.startDateString.value.toString()}-${invoiceController.endDateString.value.toString()}",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(239, 75, 72, 72)),
                      );
                    }))
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
                : Obx(() {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: invoiceController.isWalletLoading.value
                            ? invoiceController.walletTransactionLists.length +
                                1
                            : invoiceController.walletTransactionLists.length,
                        itemBuilder: (context, index) {
                          if (index <
                              invoiceController.walletTransactionLists.length) {
                            var data =
                                invoiceController.walletTransactionLists[index];
                            double number = double.parse(data.amount);
                            String formattedNumber = number.toStringAsFixed(2);
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
                                            .walletTransactionLists[index]
                                            .phone,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (data.amount == "0" ||
                                                  data.entryType == 'Credit')
                                              ? "+$formattedNumber"
                                              : "-$formattedNumber",
                                          style: GoogleFonts.roboto(
                                              color: data.entryType == "Debit"
                                                  ? Color.fromARGB(
                                                      255, 243, 106, 106)
                                                  : Colors.green,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(data.createdAt.toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300))
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
                  });
          })
        ],
      ),
    );
  }
}
