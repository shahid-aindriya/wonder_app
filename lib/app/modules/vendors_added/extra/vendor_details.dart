import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class VendorDetails extends StatelessWidget {
  const VendorDetails({super.key});

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
            title: Text(
              'Vendor Details',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Figma Flutter Generator Rectangle55Widget - RECTANGLE
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset("assets/images/User.png"),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 20),
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Basic Details",
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                            // TextButton.icon(
                            //     onPressed: () {},
                            //     icon: Icon(Icons.edit, size: 19),
                            //     label: Text("Edit",
                            //         style: GoogleFonts.roboto(
                            //             fontSize: 18.sp,
                            //             fontWeight: FontWeight.w400)))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 5.w,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Name"),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    Flexible(
                                      child: Text("Zudio Shoppee",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Location"),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Flexible(
                                      child: Text("Kakkanad",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address"),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Flexible(
                                      child: Text(
                                          "Infopark Expy, Kakkanad, Ernakulam 682030",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Category"),
                                    SizedBox(
                                      width: 18.w,
                                    ),
                                    Text("Textiles",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Vendor Name"),
                                    SizedBox(
                                      width: 11.w,
                                    ),
                                    Text("Thomas K V",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Phone"),
                                    SizedBox(
                                      width: 22.4.w,
                                    ),
                                    Text("+91 95565 55631",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Email"),
                                    SizedBox(
                                      width: 23.4.w,
                                    ),
                                    Flexible(
                                      child: Text("zudioshoppee@gmail.com",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text("Added Date"),
                                    SizedBox(
                                      width: 13.4.w,
                                    ),
                                    Text("12 September, 2023",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ),
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
        ));
  }
}
