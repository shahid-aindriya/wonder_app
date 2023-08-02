import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/invoice_controller.dart';

class SearchWalletData extends StatelessWidget {
  SearchWalletData({super.key, required this.invoiceController});
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final InvoiceController invoiceController;
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
        onWillPop: () {
          invoiceController.searchWalletTextController.clear();
          Get.back();
          throw Exception();
        },
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
                      invoiceController.searchWalletTextController.clear();
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
                  controller: invoiceController.searchWalletTextController,
                  focusNode: focusNode,
                  enabled: true,
                  style: GoogleFonts.roboto(
                      fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Color.fromRGBO(0, 0, 0, .6)),
                      hintText: "Search Here...",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 20),
                      enabled: true,
                      suffixIcon: InkWell(
                          onTap: () async {
                            invoiceController.currentPage.value = 1;
                            await invoiceController.searchWalletTransactions();
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
                  onChanged: (value) async {
                    invoiceController.currentPage.value = 1;
                    await invoiceController.searchWalletTransactions();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return Expanded(
                    child: ListView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                  controller: invoiceController.walletScrollController,
                  itemCount: invoiceController.isMoving.value
                      ? invoiceController.searchWalletTransactionList.length + 1
                      : invoiceController.searchWalletTransactionList.length,
                  itemBuilder: (context, index) {
                    // String formattedDate = DateFormat("MMM dd, yyyy")
                    //     .format(DateTime.parse(data.invoiceDate.toString()));
                    // log(formattedDate);
                    if (invoiceController.searchWalletTransactionList.isEmpty) {
                      return Center(child: Text("No data found"));
                    } else if (index <
                        invoiceController.searchWalletTransactionList.length) {
                      var data =
                          invoiceController.searchWalletTransactionList[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 15, right: 5.w, left: 5.w),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                                begin: Alignment(
                                    1.4153012037277222, 0.15562866628170013),
                                end: Alignment(
                                    -0.15562868118286133, 0.044075123965740204),
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
                              title: Text(data.phone,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data.invoiceNumber != "null"
                                      ? Text(
                                          "Incvoice Number:${data.invoiceNumber}")
                                      : Container(
                                          height: 0,
                                        ),
                                  SizedBox(
                                    height:
                                        data.invoiceNumber != "null" ? 5 : 0,
                                  ),
                                  Text(
                                    data.entryType,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
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
                                            ? Color.fromARGB(255, 243, 106, 106)
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
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                  },
                ));
              }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
