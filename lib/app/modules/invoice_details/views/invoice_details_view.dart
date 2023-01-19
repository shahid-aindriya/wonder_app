import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/invoice_details_controller.dart';

class InvoiceDetailsView extends GetView<InvoiceDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 77, 96, 221),
              onPressed: () {},
              child: Icon(Icons.download)),
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
            centerTitle: true,
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invoice Approval Request",
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "28 Dec 2022, 19:30",
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Figma Flutter Generator Rectangle17Widget - RECTANGLE
                    Container(
                      width: 100.w,
                      height: 270,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment(
                                1.1437236070632935, -0.005003529135137796),
                            end: Alignment(
                                -0.06076670065522194, 0.042849887162446976),
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0.75),
                              Color.fromRGBO(255, 255, 255, 0.3199999928474426)
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Invoice Amount of",
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 229, 223, 227)),
                                      width: 146,
                                      height: 64,
                                      child: Center(
                                        child: Text(
                                          "₹1850",
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 117, 231),
                                              fontSize: 31,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 99,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Invoice Number",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text("45656564131",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Invoice Date",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text("26 December,2022",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Requested By",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            ListTile(
                                leading: CircleAvatar(
                                    child: Image.asset(
                                        "assets/images/Ellipse 21.png")),
                                title: Text("Rakesh K Raju",
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                subtitle: Text(
                                  "+91 94666 64658",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/call.png",
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(44.w, 53)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 0, 158, 16)))),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(134, 255, 255, 255))),
                            onPressed: () {},
                            icon: Icon(Icons.check,
                                color: Color.fromARGB(255, 0, 158, 16)),
                            label: Text("Approve",
                                style: GoogleFonts.roboto(
                                    color: Color.fromARGB(255, 0, 158, 16),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(44.w, 53)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 255, 80, 80)))),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(134, 255, 255, 255))),
                            onPressed: () {},
                            icon: Icon(Icons.close,
                                color: Color.fromARGB(255, 255, 80, 80)),
                            label: Text("Decline",
                                style: GoogleFonts.roboto(
                                    color: Color.fromARGB(255, 255, 80, 80),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)))
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                    Text("Invoice Copy",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Container(
                          width: 100.w,
                          child:
                              Image.asset("assets/images/invoice_image.png")),
                    )

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height,
                    //     width: 100.w,
                    //     child: PhotoView(
                    //         imageProvider:
                    //             AssetImage('assets/images/invoice_image.png'),
                    //         minScale: PhotoViewComputedScale.contained * 0),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
