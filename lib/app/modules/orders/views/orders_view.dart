import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../data/colors.dart';
import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../invoice/views/invoice_view.dart';
import '../../invoice/widgets/drawer_tab.dart';
import '../../invoice/widgets/notification_icon.dart';
import '../../my_earnings/controllers/my_earnings_controller.dart';
import '../../notifications/views/notifications_view.dart';
import '../../products/views/products_view.dart';
import '../controllers/orders_controller.dart';
import '../extra/order_details_view.dart';

class OrdersView extends GetView<OrdersController> {
  OrdersView({super.key});

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
                                await ordersController.getListOfOrders(value);
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
          body: RefreshIndicator(
            onRefresh: () async {
              await ordersController
                  .getListOfOrders(invoiceController.selectShopId);
            },
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    top: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Active Orders",
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: 4.w,
                //   ),
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             ordersController.selectCard(1);
                //           },
                //           child: Obx(() {
                //             return select_card(
                //               textColor: ordersController.selectedCard.value != 1
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               color: ordersController.selectedCard.value == 1
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               text: "All",
                //             );
                //           }),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             ordersController.selectCard(2);
                //           },
                //           child: Obx(() {
                //             return select_card(
                //               textColor: ordersController.selectedCard.value != 2
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               color: ordersController.selectedCard.value == 2
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               text: "Pending",
                //             );
                //           }),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             ordersController.selectCard(3);
                //           },
                //           child: Obx(() {
                //             return select_card(
                //               textColor: ordersController.selectedCard.value != 3
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               color: ordersController.selectedCard.value == 3
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               text: "Processing",
                //             );
                //           }),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         InkWell(
                //           onTap: () {
                //             ordersController.selectCard(4);
                //           },
                //           child: Obx(() {
                //             return select_card(
                //               textColor: ordersController.selectedCard.value != 4
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               color: ordersController.selectedCard.value == 4
                //                   ? Color.fromARGB(255, 81, 90, 197)
                //                   : Colors.white,
                //               text: "Delivered",
                //             );
                //           }),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return ordersController.ordersList.isEmpty
                      ? Lottie.asset("assets/images/13659-no-data.json")
                      : Obx(() {
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemCount: ordersController.ordersList.length,
                              itemBuilder: (context, index) {
                                final data = ordersController.ordersList[index];
                                String formattedDate =
                                    DateFormat("h:mm a | MMM d").format(
                                        DateTime.parse(
                                            data.createdAt.toString()));
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0,
                                          left: 15,
                                          right: 15,
                                          bottom: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Order ${data.orderNumber}",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "₹${data.price}",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 81, 90, 197)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: GoogleFonts.roboto(
                                                    color: Colors.blueGrey,
                                                    fontSize: 16),
                                              ),
                                              InkWell(
                                                onTap:
                                                    data.status == "Completed"
                                                        ? null
                                                        : () {
                                                            ordersController
                                                                .showReturnPopUp(
                                                                    context,
                                                                    orderId:
                                                                        data.id);
                                                          },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color.fromARGB(
                                                          255, 81, 90, 197)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 7.0,
                                                            left: 11,
                                                            right: 11,
                                                            top: 6),
                                                    child: Row(
                                                      children: [
                                                        Obx(() {
                                                          return Text(
                                                            ordersController
                                                                .ordersList[
                                                                    index]
                                                                .status
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          );
                                                        }),
                                                        Icon(
                                                          Icons
                                                              .mode_edit_outlined,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 6,
                                                    width: 6,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            data.paymentMethod ==
                                                                    "Online"
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        1,
                                                                        134,
                                                                        54)
                                                                : Colors.red),
                                                  ),
                                                  Text(
                                                      data.paymentMethod ==
                                                              "Online"
                                                          ? " Paid"
                                                          : " Un-Paid",
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            data.paymentMethod ==
                                                                    "Online"
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        1,
                                                                        134,
                                                                        54)
                                                                : Colors.red,
                                                        fontSize: 15,
                                                      ))
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(OrderDetailsView(
                                                    id: data.id,
                                                  ));
                                                },
                                                child: Text("View Details",
                                                    style: GoogleFonts.roboto(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color.fromARGB(
                                                          255, 81, 90, 197),
                                                      fontSize: 15,
                                                    )),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                })
              ],
            ),
          )),
    );
  }
}

class select_card extends StatelessWidget {
  select_card(
      {super.key,
      required this.color,
      required this.text,
      required this.textColor});
  Color color;
  String text;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 7.0, left: 19, right: 19, top: 7),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
