import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../model/verified_model.dart';
import '../verifed_invoice/verified_invoices.dart';

class PayHalf extends StatelessWidget {
  const PayHalf({
    super.key,
    required this.widget,
    required this.amount,
    required this.phoneData,
  });

  final VerifiedInvoices widget;
  final TotalAmountData amount;

  final String? phoneData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(),
                    gradient: LinearGradient(
                      begin: Alignment(-0.934, -1),
                      end: Alignment(1.125, 1.333),
                      colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
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
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () async {
                            widget.invoiceController.openCheckoutForAllPay(
                                data: amount,
                                amounts: widget.invoiceController
                                            .additionSelectAmount.value !=
                                        0
                                    ? widget.invoiceController
                                        .additionSelectAmount.value
                                    : amount.payHalfWithGst,
                                email: amount.email,
                                name: amount.name,
                                phone: phoneData,
                                razorKey: amount.razorKey);
                          },
                          child: Obx(() {
                            return widget.invoiceController.additionSelectAmount
                                        .value !=
                                    0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Pay Half Now"),
                                      Text(
                                          "Pay only ₹${widget.invoiceController.additionSelectAmount.value} now ",
                                          style: GoogleFonts.jost(fontSize: 9))
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Pay Half Now"),
                                      Text(
                                        "Pay only ₹${amount.payHalfWithGst} now ",
                                        style: GoogleFonts.jost(fontSize: 9),
                                      )
                                    ],
                                  );
                          }))))),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../model/verified_model.dart';
// import '../verified_invoices.dart';

// class PayHalfAll extends StatelessWidget {
//   const PayHalfAll({
//     super.key,
//     required this.widget,
//     required this.amount,
//     required this.phoneData,
//   });

//   final VerifiedInvoices widget;
//   final TotalAmountData amount;
//   final String? phoneData;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border(),
//           gradient: LinearGradient(
//             begin: Alignment(-0.934, -1),
//             end: Alignment(1.125, 1.333),
//             colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
//             stops: <double>[0, 1],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x3f000000),
//               offset: Offset(0, 0.7870440483),
//               blurRadius: 2.7546541691,
//             ),
//           ],
//         ),
//         child: Padding(
//             padding: const EdgeInsets.only(left: 5, right: 5),
//             child: ElevatedButton(
//                 style: ButtonStyle(
//                     elevation: MaterialStateProperty.all(0),
//                     backgroundColor:
//                         MaterialStateProperty.all(Colors.transparent)),
//                 onPressed: () async {
//                   widget.invoiceController.openCheckoutForAllPay(
//                       data: amount,
//                       amounts: amount.halfAmount,
//                       email: amount.email,
//                       name: amount.name,
//                       phone: phoneData,
//                       razorKey: amount.razorKey);
//                 },
//                 child:

//                     // widget
//                     //         .invoiceController
//                     //         .checkBoxedList
//                     //         .contains(true)
//                     //     ?
//                     Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Pay Half Now"),
//                     Text("Pay only ₹${amount.halfAmount} now ",
//                         style: GoogleFonts.jost(fontSize: 9))
//                   ],
//                 )
//                 // : Column(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     children: [
//                 //       Text("Pay Half Now"),
//                 //       Text(
//                 //         "Pay only ₹${amount.halfAmount} now ",
//                 //         style: GoogleFonts.jost(fontSize: 9),
//                 //       )
//                 //     ],
//                 // );
//                 )));
//   }
// }
