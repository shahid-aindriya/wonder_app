import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/bank_transactions_controller.dart';

class BankTransactionsView extends GetView<BankTransactionsController> {
  BankTransactionsView({Key? key}) : super(key: key);
  final BankTransactionsController bankTransactionsController =
      Get.put(BankTransactionsController());
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
          title: Text(
            'Bank Transactions',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: FutureBuilder(
            future: bankTransactionsController.bankTransactions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Color(0xff4956b2)),
                );
              }
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final data =
                      bankTransactionsController.transactionData[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 15, right: 5.w, left: 5.w),
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
                              Color.fromRGBO(255, 255, 255, 0.6800000071525574)
                            ]),
                      ),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person),
                          ],
                        ),
                        title: Text(data.bank.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          data.transactionStatus.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (data.amount == "0" || data.entryType == 'Credit')
                                  ? "+${data.amount}"
                                  : "-${data.amount}",
                              style: GoogleFonts.roboto(
                                  color:

                                      // data.entryType == "Debit"
                                      //     ?
                                      //      Color.fromARGB(255, 243, 106, 106)
                                      //     :
                                      Colors.green,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            // Text("data.createdAt.toString()",
                            //     style: GoogleFonts.roboto(
                            //         fontSize: 10, fontWeight: FontWeight.w300))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
