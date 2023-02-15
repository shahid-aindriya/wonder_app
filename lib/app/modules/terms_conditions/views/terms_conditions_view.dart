import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/terms_conditions_controller.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  TermsConditionsView({Key? key}) : super(key: key);
  @override
  final TermsConditionsController controller =
      Get.put(TermsConditionsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.jpg"),
              fit: BoxFit.cover)),
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
          ),
          body: ListView(
            children: [
              FutureBuilder(
                future: controller.getTermsAndCondtions(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.termsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
                          child: Column(
                            children: [
                              Text(snapshot.data![index].title,
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 10,
                              ),
                              HtmlWidget(
                                snapshot.data![index].description,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/images/13659-no-data.json"),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              )
            ],
          )),
    );
  }
}
