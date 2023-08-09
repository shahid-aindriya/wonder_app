import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/orders/views/orders_view.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

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
            Padding(
              padding:
                  EdgeInsets.only(left: 5.w, top: 20, bottom: 10, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Details",
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  select_card(
                      color: Colors.white,
                      text: "Download Invoice",
                      textColor: Color.fromARGB(255, 81, 90, 197))
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 4.w, right: 4.w, top: 20, bottom: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order#53153134645",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                          Text("12:05 PM | Jan 5",
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
                          Text("Thomas Anderson",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text(
                        "Gh 11321 Building, Buckingham Street, Borivali South, Mumbai , 400 004+91 85416 66564",
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
              padding:
                  EdgeInsets.only(left: 4.w, right: 4.w, top: 10, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(117, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, left: 4.w, right: 4.w, bottom: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Status",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        select_card(
                            color: Colors.white,
                            text: "Order Accepted",
                            textColor: Color.fromARGB(255, 81, 90, 197))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Partner",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "October 10, 2023",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Status",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "October 10, 2023",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "Cash on Delivery",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "₹260",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Status",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 4.w, right: 4.w, bottom: 20),
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
                          Image.asset("assets/images/image 87.png"),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Surf Excel Quick wash machine Specialist powder",
                              style: GoogleFonts.roboto(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "500g  Pack of 1",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹260",
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
        ),
      ),
    );
  }
}
