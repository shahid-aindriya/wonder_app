import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/orders/controllers/orders_controller.dart';
import 'package:wonder_app/app/modules/orders/views/orders_view.dart';

class OrderDetailsView extends StatelessWidget {
  OrderDetailsView({super.key, required this.id});
  final id;
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          // title: Text(
          //   'Chat List',
          //   style: GoogleFonts.jost(
          //     fontSize: 22,
          //     fontWeight: FontWeight.w500,
          //     color: Color(0xff4956b2),
          //   ),
          // ),
        ),
        body: ListView(
          children: [
            FutureBuilder(
                future: ordersController.orderDetails(id),
                builder: (conte, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  if (ordersController.orderDetailsList.isEmpty) {
                    return Lottie.asset("assets/images/13659-no-data.json");
                  }
                  final data = ordersController.orderDetailsList.first;
                  String formattedDate = DateFormat("h:mm a | MMM d")
                      .format(DateTime.parse(data.createdAt.toString()));
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5.w, top: 20, bottom: 10, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Details",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            // select_card(
                            //     color: Colors.white,
                            //     text: "Download Invoice",
                            //     textColor: Color.fromARGB(255, 81, 90, 197))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 4.w, right: 4.w, top: 20, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(117, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15.0, left: 4.w, right: 4.w, bottom: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ${data.orderNumber}",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    Text(formattedDate,
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey, fontSize: 14))
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text("   Delivery Address",
                                        style: GoogleFonts.roboto(fontSize: 14))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(data.userAddressData.name,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Text(
                                  "${data.userAddressData.houseName}, ${data.userAddressData.roadName}, ${data.userAddressData.landMark}, ${data.userAddressData.state}, ${data.userAddressData.pinCode}, ${data.userAddressData.phoneNumber} ",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      wordSpacing: 1.4,
                                      height: 1.5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 4.w, right: 4.w, top: 10, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(117, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15.0, left: 4.w, right: 4.w, bottom: 20),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Status",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  InkWell(
                                    onTap: data.status == "Completed"
                                        ? null
                                        : () {
                                            ordersController.showReturnPopUp(
                                                context,
                                                orderId: id);
                                          },
                                    child: select_card(
                                        color: Colors.white,
                                        text: data.status,
                                        textColor:
                                            Color.fromARGB(255, 81, 90, 197)),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Delivery Partner",
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 16,
                              //           color: Color.fromARGB(255, 0, 0, 0)),
                              //     ),
                              //     Text(
                              //       "October 10, 2023",
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w500,
                              //           color: Color.fromARGB(255, 0, 0, 0)),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Order Status",
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 16,
                              //           color: Color.fromARGB(255, 0, 0, 0)),
                              //     ),
                              //     Text(
                              //       data.,
                              //       style: GoogleFonts.roboto(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w500,
                              //           color: Color.fromARGB(255, 0, 0, 0)),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Method",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    data.paymentMethod,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Amount",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    "₹${data.price}",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4956b2)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Status",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  Text(
                                    data.paymentStatus.toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4956b2)),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, left: 4.w, right: 4.w, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          "$baseUrlForImage${data.productImage}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.productName,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data.orderNumber,
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.blueGrey),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "₹${data.price}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff4956b2)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
