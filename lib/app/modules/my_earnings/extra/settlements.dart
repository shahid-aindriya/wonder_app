import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Settlements extends StatelessWidget {
  const Settlements({super.key});

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
            'Settlements',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Settled Amount",
                      style: GoogleFonts.roboto(color: Color(0xff4956b2)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: null,
                                child: Text(
                                  "₹1234",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )))),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                    height: 30,
                    child: VerticalDivider(
                      thickness: 1.3,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Text(
                      "Pending Amount",
                      style: GoogleFonts.roboto(color: Color(0xff4956b2)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 73, 117, 231))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 14, right: 14),
                        child: Center(
                          child: AutoSizeText(
                            "₹100",
                            minFontSize: 25,
                            maxFontSize: 30,
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                                color: Color.fromARGB(255, 73, 117, 231),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 9.w),
                  child: Text(
                    "Settlement History",
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
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
                      isThreeLine: false,
                      title: Text(
                        "Settled Amount",
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      subtitle: Text(
                        "₹1234",
                        style: GoogleFonts.roboto(
                            color: Color(0xff4956b2),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "12:05 PM | Oct 5, 2023",
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "12:00 AM | Oct 3, 2023",
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
