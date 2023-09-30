import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/colors.dart';
import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../invoice/views/invoice_view.dart';
import '../../invoice/widgets/drawer_tab.dart';
import '../../invoice/widgets/notification_icon.dart';
import '../../notifications/views/notifications_view.dart';
import '../../products/views/products_view.dart';
import '../controllers/my_earnings_controller.dart';

class MyEarningsView extends GetView<MyEarningsController> {
  MyEarningsView({Key? key}) : super(key: key);
  final AddInvoiceController addInvoiceController = Get.find();
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
          drawer: DrawerTab(addInvoiceController: addInvoiceController),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Builder(builder: (contezxt) {
              return InkWell(
                onTap: () async {
                  await invoiceController.getUserData();
                  Scaffold.of(contezxt).openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Icon(
                      Icons.menu,
                      color: textGradientBlue,
                    ),
                  ),
                ),
              );
            }),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FutureBuilder(
                    future: invoiceController.getListOfShops(),
                    builder: (contextsd, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 60.w,
                          height: 50,
                          child: Shimmer(
                            color: Color.fromARGB(255, 185, 84, 84),
                            child: ListTile(
                              dense: true,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 220, 216, 216),
                                    radius: 20,
                                  ),
                                ],
                              ),
                              title: Container(
                                height: 20,
                                color: Color.fromARGB(255, 220, 216, 216),
                              ),
                              subtitle: Container(
                                height: 16,
                                margin: EdgeInsets.only(top: 8),
                                color: Color.fromARGB(255, 220, 216, 216),
                              ),
                            ),
                            direction: ShimmerDirection.fromRTLB(),
                          ),
                        );
                      }
                      return Obx(() {
                        return Container(
                            width: 60.w,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              isDense: true,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    height: 1.1725,
                                    color: Color.fromARGB(93, 0, 0, 0),
                                  ),
                                  hintText: "Select Shop",
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: Color.fromARGB(
                                              255, 199, 199, 179))),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      borderRadius: BorderRadius.circular(16)),
                                  fillColor: Color.fromARGB(153, 255, 255, 255),
                                  focusColor:
                                      Color.fromARGB(255, 231, 231, 231)),
                              value: invoiceController.selectShopId,
                              onChanged: (value) async {
                                invoiceController.invoiceListsFilter.value
                                    .clear();
                                invoiceController.walletTransactionLists
                                    .clear();
                                invoiceController.invoiceLists.value.clear();
                                invoiceController.walletCurrentpage.value = 1;
                                invoiceController.invoiceCurrentpage.value = 1;
                                invoiceController.shopWalletAmount.value = "0";
                                invoiceController.dueList.clear();
                                invoiceController.walletAmount.value = '';
                                invoiceController.filterPage.value = 1;
                                invoiceController.dueTotalCount.value = 1;
                                invoiceController.dueCurrentCount.value = 1;
                                invoiceController.debitListValue.value = "All";
                                invoiceController.changeShop(
                                  value: value,
                                );
                                await invoiceController.checkVerifiedVendor();
                                await myEarningsController.getMyEarnings(value);
                                await invoiceController
                                    .onDropDownChanged(value);
                                await invoiceController
                                    .ondropDownChangedInvoice(value);
                                await invoiceController.getDueData();
                                await productsController
                                    .getListOfPrdoucts(value);
                              },
                              items:
                                  invoiceController.shopLists.value.map((data) {
                                return DropdownMenuItem(
                                    value: data.id.toString(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        data.name,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ));
                              }).toList(),
                            ));
                      });
                    }),
              ),
              Container(
                decoration: BoxDecoration(),
                child: InkWell(
                  onTap: () {
                    Get.to(NotificationsView(
                      invoiceController: invoiceController,
                    ));
                  },
                  child: Center(
                    child: BellWidget(),
                  ),
                ),
              )
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Total Earnings",
                          style: GoogleFonts.roboto(color: Color(0xff4956b2)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(130, 45)),
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: null,
                                    child: Obx(() {
                                      return Text(
                                        "₹ ${myEarningsController.totalAmount.value.isEmpty ? 0.0 : myEarningsController.totalAmount.value}",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      );
                                    })))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //         elevation: MaterialStateProperty.all(0),
                    //         minimumSize:
                    //             MaterialStateProperty.all(Size(127, 34)),
                    //         shape: MaterialStateProperty.all(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10))),
                    //         side: MaterialStateProperty.all(BorderSide(
                    //           color: Color(0xff4956b2),
                    //         )),
                    //         backgroundColor:
                    //             MaterialStateProperty.all(Colors.white)),
                    //     onPressed: () {
                    //       Get.to(Settlements());
                    //     },
                    //     child: Text(
                    //       "withdraw",
                    //       style: GoogleFonts.inter(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 14,
                    //           color: Color(0xff4956b2)),
                    //     )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            "Earnings History",
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() {
                return myEarningsController.earningslist.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/images/13659-no-data.json"),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: myEarningsController.earningslist.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = myEarningsController.earningslist[index];
                          String inputDate = data.createdAt.toString();

                          // Define the input format to match the provided date format
                          DateFormat inputFormat =
                              DateFormat("yyyy MMM dd, hh:mm a");

                          // Parse the input date string
                          DateTime parsedDate = inputFormat.parse(inputDate);

                          // Define the output format
                          DateFormat outputFormat =
                              DateFormat("hh:mm a | MMM dd");

                          // Format the parsed date into the desired format
                          String formattedDate =
                              outputFormat.format(parsedDate);
                          final amount = num.tryParse(data.amount.toString())! -
                              num.tryParse(
                                  data.paymentGatewayAmount.toString())!;
                          final total = amount -
                              num.tryParse(data.deliveryCharge.toString())!;
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
                              child: ListTile(
                                isThreeLine: false,
                                title: Text("Order# ${data.id}",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Earnings  ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          "₹${data.amount}",
                                          style: GoogleFonts.roboto(
                                              color: Color(0xff4956b2),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          "Order Value:  ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          "₹$total",
                                          style: GoogleFonts.roboto(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          "Delivery Charge:  ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          "₹${data.deliveryCharge}",
                                          style: GoogleFonts.roboto(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          "Payment Gateway Amount:  ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          "₹${data.paymentGatewayAmount}",
                                          style: GoogleFonts.roboto(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              })
            ],
          )),
    );
  }
}
