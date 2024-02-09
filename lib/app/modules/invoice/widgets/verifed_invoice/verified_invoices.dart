import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/bank_transactions/views/bank_transactions_view.dart';
import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/invoice/widgets/verifed_invoice/progress_indicator.dart';

import '../../../../data/colors.dart';
import '../../../invoice_details/views/invoice_details_view.dart';
import '../../controllers/invoice_payment_controller.dart';
import '../buttons/pay_half_all.dart';
import '../buttons/pay_later.dart';
import '../buttons/pay_manually.dart';
import '../buttons/shop_balance.dart';
import '../buttons/withdraw_button.dart';

class VerifiedInvoices extends StatefulWidget {
  final InvoiceController invoiceController;
  const VerifiedInvoices({super.key, required this.invoiceController});

  @override
  State<VerifiedInvoices> createState() => _VerifiedInvoicesState();
}

class _VerifiedInvoicesState extends State<VerifiedInvoices> {
  onWillPop2() async {
    // Return true to allow the back button to work normally.
    widget.invoiceController.selecteddCommission.value = 0;
    widget.invoiceController.checkButton.value = false;
    widget.invoiceController.selecteddCommissionCount.value = 0;
    widget.invoiceController.checkBoxedList =
        RxList.filled(widget.invoiceController.checkBoxedList.length, false);
    widget.invoiceController.totalSelectedCommissionAmount.value = 0;
    widget.invoiceController.dueSelectAmount.value = 0;
    widget.invoiceController.idOfVerifiedList.clear();
    widget.invoiceController.totalVerifiedCount.value = 1;
    widget.invoiceController.currentVerifiedCount.value = 1;
    widget.invoiceController.verifiedList.clear();
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    widget.invoiceController.verifiedInvoiceList();
    // InvoicePaymentController invoicePaymentController =
    //     InvoicePaymentController();
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
            await onWillPop2();
            throw Exception();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(117, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        widget.invoiceController.selecteddCommissionCount
                            .value = 0;
                        widget.invoiceController.selecteddCommission.value = 0;
                        widget.invoiceController.checkButton.value = false;
                        widget.invoiceController.checkBoxedList = RxList.filled(
                            widget.invoiceController.checkBoxedList.length,
                            false);
                        widget.invoiceController.totalSelectedCommissionAmount
                            .value = 0;
                        widget.invoiceController.additionSelectAmount.value = 0;
                        widget.invoiceController.dueSelectAmount.value = 0;
                        widget.invoiceController.totalVerifiedCount.value = 1;
                        widget.invoiceController.currentVerifiedCount.value = 1;
                        widget.invoiceController.verifiedList.clear();
                        widget.invoiceController.idOfVerifiedList.clear();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xff4956b2),
                      )),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Verified Invoices',
                style: GoogleFonts.jost(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4956b2),
                ),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Get.to(BankTransactionsView());
                    },
                    child: SvgPicture.asset(
                        "assets/images/history-svgrepo-com 1.svg")),
                Obx(() {
                  return IconButton(
                      onPressed: () {
                        if (widget.invoiceController.checkButton.value ==
                            false) {
                          widget.invoiceController.checkButton.value = true;
                        } else {
                          widget.invoiceController.checkButton.value = false;
                        }
                        widget.invoiceController.selecteddCommission.value = 0;

                        widget.invoiceController.selecteddCommissionCount
                            .value = 0;
                        widget.invoiceController.checkBoxedList = RxList.filled(
                            widget.invoiceController.checkBoxedList.length,
                            false);
                        widget.invoiceController.idOfVerifiedList.clear();
                        widget.invoiceController.totalSelectedCommissionAmount
                            .value = 0;
                        widget.invoiceController.dueSelectAmount.value = 0;
                        widget.invoiceController.additionSelectAmount.value = 0;
                      },
                      icon: Icon(
                        widget.invoiceController.checkButton.value == false
                            ? Icons.edit
                            : Icons.close,
                        color: Color(0xff4956b2),
                      ));
                })
              ],
            ),
            body: ListView(
              controller: widget.invoiceController.verifiedScrollController,
              children: [
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: widget.invoiceController.verifiedInvoiceList(),
                    builder: (conertext, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        );
                      }

                      return Obx(() {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget
                                .invoiceController.verifiedAmountData.length,
                            shrinkWrap: true,
                            itemBuilder: (contextsdf, index) {
                              var amount = widget
                                  .invoiceController.verifiedAmountData[index];
                              widget.invoiceController.halfAmount =
                                  amount.halfAmount;
                              widget.invoiceController.payHalfWithGst =
                                  amount.payHalfWithGst;
                              var phoneData = widget
                                      .invoiceController.verifiedList.isNotEmpty
                                  ? widget.invoiceController.verifiedList[index]
                                      .vendorPhone
                                  : null;
                              // invoicePaymentController.shopId =
                              //     invoiceController.verifiedList.first.shopId;
                              return Column(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Total Amount",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 73, 117, 231))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8,
                                                  left: 14,
                                                  right: 14),
                                              child: AutoSizeText(
                                                "₹${amount.totalAmount}",
                                                minFontSize: 25,
                                                maxFontSize: 30,
                                                maxLines: 2,
                                                style: GoogleFonts.roboto(
                                                    color: Color.fromARGB(
                                                        255, 73, 117, 231),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Obx(() {
                                        return Visibility(
                                          visible: (widget.invoiceController
                                                  .checkButton.isTrue)
                                              ? true
                                              : false,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Selected Amount",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Color.fromARGB(
                                                              255,
                                                              73,
                                                              117,
                                                              231))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 8,
                                                            left: 14,
                                                            right: 14),
                                                    child: AutoSizeText(
                                                      "₹${widget.invoiceController.totalSelectedCommissionAmount.value}",
                                                      minFontSize: 25,
                                                      maxFontSize: 30,
                                                      maxLines: 2,
                                                      style: GoogleFonts.roboto(
                                                          color: Color.fromARGB(
                                                              255,
                                                              73,
                                                              117,
                                                              231),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.w, top: 10, bottom: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Withdrawal Amount",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        child: Column(
                                          children: [
                                            ShopBalance(amount: amount),
                                            WithdrawButton(amount: amount),
                                            Obx(() {
                                              return Visibility(
                                                visible: invoiceController
                                                        .idOfVerifiedList
                                                        .isEmpty
                                                    ? false
                                                    : true,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      invoiceController
                                                          .payByWallet();
                                                    },
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white)),
                                                    child: Text(
                                                      "Pay by walllet",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromARGB(
                                                              255,
                                                              73,
                                                              86,
                                                              178)),
                                                    )),
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 15.h,
                                          child: VerticalDivider(
                                            thickness: 2,
                                          )),
                                      Container(
                                        width: 55.w,
                                        child: Column(
                                          children: [
                                            PayHalf(
                                              widget: widget,
                                              amount: amount,
                                              phoneData: phoneData,
                                            ),
                                            PayManually(
                                                amount: widget.invoiceController
                                                    .halfAmount),
                                            PayLater(
                                                widget: widget, amount: amount),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            });
                      });
                    }),
                Obx(() {
                  return Visibility(
                    visible: widget.invoiceController.checkButton.isTrue
                        ? true
                        : false,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Obx(() {
                        return Text(
                            "${widget.invoiceController.selecteddCommissionCount.value} Selected");
                      }),
                    ),
                  );
                }),
                Obx(() {
                  return (widget.invoiceController.isVerifyLoading.value ==
                          true)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.h),
                            CircularProgressIndicator()
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await widget.invoiceController
                                .ondropDownChangedInvoice(
                                    widget.invoiceController.selectShopId);
                          },
                          child: Obx(() {
                            return widget.invoiceController.verifiedList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.invoiceController
                                              .isVerfiedInvoiceLoading.value
                                          ? widget.invoiceController
                                                  .verifiedList.length +
                                              1
                                          : widget.invoiceController
                                              .verifiedList.length,
                                      itemBuilder: (contexst, index) {
                                        if (index <
                                            widget.invoiceController
                                                .verifiedList.length) {
                                          var datas = widget.invoiceController
                                              .verifiedList[index];
                                          widget.invoiceController.invoiceId =
                                              datas.id;
                                          widget.invoiceController.amount =
                                              datas.amountData.additionalAmount;
                                          String formattedDate =
                                              DateFormat("MMM dd, yyyy").format(
                                                  DateTime.parse(datas
                                                      .invoiceDate
                                                      .toString()));
                                          // log(formattedDate);

                                          return InkWell(
                                            onTap: () async {
                                              Get.to(InvoiceDetailsView(
                                                id: datas.id,
                                              ));
                                            },
                                            child: Slidable(
                                              enabled:
                                                  datas.payHalfAmount == true
                                                      ? false
                                                      : true,
                                              // Specify a key if the Slidable is dismissible.
                                              key: const ValueKey(0),

                                              // The start action pane is the one at the left or the top side.
                                              endActionPane: ActionPane(
                                                extentRatio: .2,
                                                dragDismissible: false,
                                                // A motion is a widget used to control how the pane animates.
                                                motion: const ScrollMotion(),

                                                // A pane can dismiss the Slidable.

                                                // All actions are defined in the children parameter.
                                                children: [
                                                  // InkWell(
                                                  //   onLongPress: () {},
                                                  //   onTap:
                                                  //       // datas.payHalfAmount ==
                                                  //       //         false
                                                  //       //     ?
                                                  //       //     () {
                                                  //       //         Get.snackbar(
                                                  //       //             "Error",
                                                  //       //             "Can't approve this Invoice",
                                                  //       //             backgroundColor:
                                                  //       //                 Colors
                                                  //       //                     .red);
                                                  //       //       }
                                                  //       // :
                                                  //       () async {
                                                  //     log("message");
                                                  //     datas.amountData.additionalAmount ==
                                                  //             0
                                                  //         ? await widget
                                                  //             .invoiceController
                                                  //             .approveOrDeclineInvoice(
                                                  //                 choice:
                                                  //                     "Approve",
                                                  //                 context:
                                                  //                     context,
                                                  //                 invoiceId:
                                                  //                     datas
                                                  //                         .id)
                                                  //         : await widget
                                                  //             .invoiceController
                                                  //             .openCheckout(
                                                  //             amount: datas
                                                  //                 .amountData
                                                  //                 .additionalAmount,
                                                  //             email: datas
                                                  //                 .amountData
                                                  //                 .email,
                                                  //             invoiceId:
                                                  //                 datas.id,
                                                  //             name: datas
                                                  //                 .amountData
                                                  //                 .name,
                                                  //             razorKey: datas
                                                  //                 .amountData
                                                  //                 .razorKey,
                                                  //             data: datas
                                                  //                 .amountData,
                                                  //           );
                                                  //   },
                                                  //   child: Container(
                                                  //     height: 70,
                                                  //     width: 54,
                                                  //     child: Image.asset(
                                                  //       "assets/images/approve.png",
                                                  //       fit: BoxFit.cover,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      widget.invoiceController
                                                          .approveOrDeclineInvoice(
                                                              choice: "Reject",
                                                              context: context,
                                                              invoiceId:
                                                                  datas.id);
                                                    },
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

                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 100.w,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    gradient: LinearGradient(
                                                        begin: Alignment(
                                                            1.1437236070632935,
                                                            -0.005003529135137796),
                                                        end: Alignment(
                                                            -0.06076670065522194,
                                                            0.042849887162446976),
                                                        colors: [
                                                          Color.fromRGBO(255,
                                                              255, 255, 0.75),
                                                          Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.3199999928474426)
                                                        ]),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Obx(() {
                                                        return Visibility(
                                                          visible: widget
                                                                  .invoiceController
                                                                  .checkButton
                                                                  .isFalse
                                                              ? false
                                                              : true,
                                                          child: Checkbox(
                                                            value: widget
                                                                .invoiceController
                                                                .checkBoxedList[index],
                                                            onChanged:
                                                                (value) async {
                                                              widget.invoiceController.checBoxFunct(
                                                                  dueAmount: datas
                                                                      .amountData
                                                                      .vendorBalance,
                                                                  value: value,
                                                                  index: index,
                                                                  commissionAmount: datas
                                                                      .amountData
                                                                      .commissionAmount,
                                                                  walletAmount: datas
                                                                      .amountData
                                                                      .currentAmount,
                                                                  preTaxAmount:
                                                                      datas
                                                                          .preTaxAmount,
                                                                  addiTionalAmount: datas
                                                                      .amountData
                                                                      .additionalAmount);
                                                              widget
                                                                  .invoiceController
                                                                  .toggleIdSelection(
                                                                      datas.id);
                                                              // log(widget
                                                              //     .invoiceController
                                                              //     .idOfVerifiedList
                                                              //     .toString());
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                      Visibility(
                                                        visible:
                                                            datas.payHalfAmount ==
                                                                        true &&
                                                                    datas.bulkApproveStatus ==
                                                                        true
                                                                ? true
                                                                : false,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 3.0,
                                                                  left: 10),
                                                          child: Container(
                                                            width: 5,
                                                            height: 5,
                                                            child: Icon(
                                                              Icons
                                                                  .verified_user_sharp,
                                                              size: 20,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      43,
                                                                      154,
                                                                      54),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          229,
                                                                          223,
                                                                          227)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  maxLines: 2,
                                                                  "₹${datas.preTaxAmount}",
                                                                  maxFontSize:
                                                                      18,
                                                                  minFontSize:
                                                                      12,
                                                                  style: GoogleFonts.roboto(
                                                                      color: datas.status ==
                                                                              "Verified"
                                                                          ? Color.fromARGB(
                                                                              255,
                                                                              73,
                                                                              117,
                                                                              231)
                                                                          : greyColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          3.w),
                                                              child: Text(
                                                                formattedDate,
                                                                style: GoogleFonts.roboto(
                                                                    color: datas.status ==
                                                                            "Verified"
                                                                        ? Colors
                                                                            .black
                                                                        : greyColor,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 14.0,
                                                                      left:
                                                                          2.w),
                                                              child: Column(
                                                                children: [
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'By ',
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 16,
                                                                              color: datas.status == "Verified" ? Colors.black : greyColor,
                                                                              fontWeight: FontWeight.w300),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              datas.phone,
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: 14,
                                                                              color: datas.status == "Verified" ? Colors.black : greyColor,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 13,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          " Invoice No: ${datas.invoiceNumber}  ",
                                                                          style: GoogleFonts.roboto(
                                                                              color: datas.status == "Verified" ? Colors.black : greyColor,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300)),
                                                                      Visibility(
                                                                        visible: datas.payHalfAmount ==
                                                                                true
                                                                            ? true
                                                                            : false,
                                                                        child:
                                                                            Wrap(
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: 8,
                                                                              height: 8,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 67, 213, 82)),
                                                                            ),
                                                                            Text(" Paid",
                                                                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 67, 213, 82), fontSize: 12, fontWeight: FontWeight.w500))
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
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
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 3.0,
                                                                      bottom: 3,
                                                                      left: 4,
                                                                      right: 4),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/images/verified.svg"),
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
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator()
                                            ],
                                          );
                                        }
                                      },
                                    );
                                  });
                          }),
                        );
                })
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Obx(() {
              return Visibility(
                visible: invoiceController.showButtonValue.value == true
                    ? true
                    : false,
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
                              Get.to(ProgressIndicatorView());
                              log(widget.invoiceController.verifiedAmountData
                                  .first.shopWalletAmount
                                  .toString());
                              invoicePaymentController.bulkApproval(
                                  widget.invoiceController.verifiedList,
                                  widget.invoiceController.verifiedAmountData
                                      .first.shopWalletAmount);
                            },
                            child: Text(
                              "Approve",
                              style: GoogleFonts.roboto(color: Colors.white),
                            )))),
              );
            }),
          ),
        ));
  }

  // void getDataFromFirebase() async{

  //   print("getDataFromFirebase");
  //   final firebaseApp = Firebase.app();
  //   final rtdb = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://console.firebase.google.com/project/wonderapp-73f65/database/wonderapp-73f65-default-rtdb/data.firebaseio.com/');
  //   await Firebase.initializeApp(); // Make sure Firebase is initialized before accessing its services.

  //   // final rtdbs = FirebaseDatabase.instance;
  //   // print("${rtdbs.ref().child("shops_tb")}");

  //   final rtdbs = FirebaseDatabase.instance.ref().child("shops_tb");
  //   rtdbs.onValue.listen((event) {
  //     DataSnapshot snapshot = event.snapshot;
  //     print(snapshot.value);
  //   });

  // }
}

class LoadingDialog {
  static void show(BuildContext context) {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  static void hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 10, bottom: 30),
                                  //   child: Obx(() {
                                  //     return Visibility(
                                  //       visible: (widget
                                  //                       .invoiceController
                                  //                       .verifiedAmountData[
                                  //                           index]
                                  //                       .totalAmount ==
                                  //                   0 ||
                                  //               widget.invoiceController
                                  //                   .checkButton.isTrue)
                                  //           ? false
                                  //           : true,
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Container(
                                  //               height: 40,
                                  //               decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10),
                                  //                 border: Border(),
                                  //                 gradient: LinearGradient(
                                  //                   begin:
                                  //                       Alignment(-0.934, -1),
                                  //                   end:
                                  //                       Alignment(1.125, 1.333),
                                  //                   colors: <Color>[
                                  //                     Color(0xe53f46bd),
                                  //                     Color(0xe5417de8)
                                  //                   ],
                                  //                   stops: <double>[0, 1],
                                  //                 ),
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Color(0x3f000000),
                                  //                     offset: Offset(
                                  //                         0, 0.7870440483),
                                  //                     blurRadius: 2.7546541691,
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               child: Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.only(
                                  //                           left: 20,
                                  //                           right: 20),
                                  //                   child: ElevatedButton(
                                  //                       style: ButtonStyle(
                                  //                           elevation:
                                  //                               MaterialStateProperty
                                  //                                   .all(0),
                                  //                           backgroundColor:
                                  //                               MaterialStateProperty
                                  //                                   .all(Colors
                                  //                                       .transparent)),
                                  //                       onPressed: () async {
                                  //                         log(amount.totalAmount
                                  //                             .toString());
                                  //                         widget
                                  //                             .invoiceController
                                  //                             .openCheckoutForAllPay(
                                  //                                 razorKey: amount
                                  //                                     .razorKey,
                                  //                                 name:
                                  //                                     amount
                                  //                                         .name,
                                  //                                 amounts: amount
                                  //                                     .totalAmount,
                                  //                                 email: amount
                                  //                                     .email,
                                  //                                 phone:
                                  //                                     phoneData,
                                  //                                 data: amount);
                                  //                       },
                                  //                       child: Text("Pay")))),
                                  //         ],
                                  //       ),
                                  //     );
                                  //   }),
                                  // ),

                                    // Obx(() {
                                                //   return Visibility(
                                                //     visible: widget
                                                //                 .invoiceController
                                                //                 .totalSelectedCommissionAmount
                                                //                 .value >
                                                //             0
                                                //         ? true
                                                //         : false,
                                                //     child: Container(
                                                //         height: 40,
                                                //         decoration:
                                                //             BoxDecoration(
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(10),
                                                //           border: Border(),
                                                //           gradient:
                                                //               LinearGradient(
                                                //             begin: Alignment(
                                                //                 -0.934, -1),
                                                //             end: Alignment(
                                                //                 1.125, 1.333),
                                                //             colors: <Color>[
                                                //               Color(0xe53f46bd),
                                                //               Color(0xe5417de8)
                                                //             ],
                                                //             stops: <double>[
                                                //               0,
                                                //               1
                                                //             ],
                                                //           ),
                                                //           boxShadow: [
                                                //             BoxShadow(
                                                //               color: Color(
                                                //                   0x3f000000),
                                                //               offset: Offset(0,
                                                //                   0.7870440483),
                                                //               blurRadius:
                                                //                   2.7546541691,
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         child: Padding(
                                                //             padding:
                                                //                 const EdgeInsets
                                                //                         .only(
                                                //                     left: 20,
                                                //                     right: 20),
                                                //             child:
                                                //                 ElevatedButton(
                                                //                     style: ButtonStyle(
                                                //                         elevation:
                                                //                             MaterialStateProperty.all(
                                                //                                 0),
                                                //                         backgroundColor:
                                                //                             MaterialStateProperty.all(Colors
                                                //                                 .transparent)),
                                                //                     onPressed:
                                                //                         () async {
                                                //                       widget.invoiceController.openCheckoutForAllPay3(
                                                //                           razorKey: amount
                                                //                               .razorKey,
                                                //                           name: amount
                                                //                               .name,
                                                //                           amounts: widget
                                                //                               .invoiceController
                                                //                               .totalSelectedCommissionAmount
                                                //                               .value,
                                                //                           email: amount
                                                //                               .email,
                                                //                           data:
                                                //                               amount,
                                                //                           phone:
                                                //                               phoneData);
                                                //                     },
                                                //                     child: Text(
                                                //                         "Pay")))),
                                                //   );
                                                // }),