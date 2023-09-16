import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/colors.dart';
import '../controllers/taxes_controller.dart';

class TaxesView extends GetView<TaxesController> {
  const TaxesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
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
              'Taxes',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 20),
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0.2),
                        blurRadius: 10,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 243, 229, 223),
                        Color.fromARGB(255, 229, 230, 244)
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Color.fromARGB(255, 151, 151, 155),
                    labelStyle: GoogleFonts.roboto(
                        color: textGradientBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 0.7870440483093262),
                            blurRadius: 5.509308338165283)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              0.8374384045600891, 0.11822659522294998),
                          end: Alignment(
                              -0.11822660267353058, 0.10431758314371109),
                          colors: [
                            Color.fromRGBO(63, 70, 189, 1),
                            Color.fromRGBO(65, 125, 232, 1)
                          ]),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    "TDS",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 2),
                                    child: Text(
                                      "GST",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 5.w),
                      child: Row(
                        children: [
                          Text("TDS",
                              style: GoogleFonts.jost(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 73, 86, 178))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index1) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 15, right: 5.w, left: 5.w),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5),
                                  child: ListTile(
                                    isThreeLine: false,
                                    title: Text("Order#787666755564356",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "Total Amount:",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text("  ₹100000000",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 73, 86, 178),
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ],
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "TDS Amount:",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text("   ₹100",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 73, 86, 178),
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "12:05 PM | Jan 16",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 94, 92, 92)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Online",
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 86, 178)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 5.w),
                      child: Row(
                        children: [
                          Text("GST",
                              style: GoogleFonts.jost(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 73, 86, 178))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index1) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 15, right: 5.w, left: 5.w),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ListTile(
                                    isThreeLine: false,
                                    title: Text("Order#787666755564356",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "Total Amount:",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text("  ₹100000000",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 73, 86, 178),
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ],
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "GST Amount:",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text("   ₹100",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 73, 86, 178),
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "12:05 PM | Jan 16",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 94, 92, 92)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Online",
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 73, 86, 178)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
