import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

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
          ],
        ),
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
            'Request Details',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 5.w, right: 5.w),
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.2),
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Request No 877878898797",
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "12 October 2023 | 12:15 PM",
                            style: GoogleFonts.roboto(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Request Title",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                "Suspendisse elementum in tincidunt facilisis vitae risus diam quis adipiscing.",
                                style: GoogleFonts.roboto(
                                    wordSpacing: 2,
                                    color: Color.fromARGB(255, 148, 145, 145)),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Request Description  ",
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                "Lacus integer nullam a eros ultrices pellentesque morbi. Suspendisse elementum in tincidunt facilisis vitae risus diam quis adipiscing. Dictum.",
                                style: GoogleFonts.roboto(
                                    wordSpacing: 2,
                                    color: Color.fromARGB(255, 148, 145, 145)),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.2),
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Wonder Points Support Team",
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "12 October 2023 | 12:15 PM",
                            style: GoogleFonts.roboto(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                "Your request has been submitted. Our relationship manager will reach you back shortly",
                                style: GoogleFonts.roboto(
                                    wordSpacing: 2,
                                    color: Color.fromARGB(255, 148, 145, 145)),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.2),
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Wonder Points Support Team",
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "12 October 2023 | 12:15 PM",
                            style: GoogleFonts.roboto(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                "We have assigned Mr Ram Mohan to help you with your request no 877878898797. He will reach out shortly ",
                                style: GoogleFonts.roboto(
                                    wordSpacing: 2,
                                    color: Color.fromARGB(255, 148, 145, 145)),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: () {},
                                    child: Text(
                                      '  Contact   ',
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2110513051,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "No need of assistance ?  ",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 109, 107, 107)),
                      ),
                      Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.2),
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {},
                            child: Text(
                              'Cancel Appointment',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.2110513051,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
