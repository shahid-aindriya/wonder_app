import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/colors.dart';
import '../controllers/taxes_controller.dart';
import '../widgets/gst_view.dart';
import '../widgets/tds_view.dart';

class TaxesView extends GetView<TaxesController> {
  TaxesView({Key? key}) : super(key: key);

  final TaxesController taxesController = Get.put(TaxesController());
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
                TdsView(
                  taxesController: taxesController,
                ),
                GstView(
                  taxesController: taxesController,
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
