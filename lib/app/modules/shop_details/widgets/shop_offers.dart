import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/shop_details/controllers/shop_details_controller.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/add_offer.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/edit%20_offer.dart';

class ShopOffers extends GetView<ShopDetailsController> {
  @override
  final shopId;
  @override
  final ShopDetailsController controller;
  ShopOffers({super.key, required this.controller, this.shopId});

  @override
  Widget build(BuildContext context) {
    controller.getOffers();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
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
            'Offers',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 20, bottom: 15),
              child: Text(
                "Offers",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Obx(() {
              return controller.offerdatas.isEmpty
                  ? Column(
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
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.offerdatas.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          var data = controller.offerdatas[index];
                          return InkWell(
                            onTap: () {
                              Get.to(EditOffer(
                                data: data,
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.15000000596046448),
                                      offset: Offset(0, 2),
                                      blurRadius: 7)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment(1, 0),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color.fromRGBO(200, 78, 137, 1),
                                      Color.fromRGBO(241, 95, 121, 1)
                                    ]),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Text(
                                        "₹${data.discount} OFF",
                                        style: GoogleFonts.montserrat(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.4.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Container(
                                        child: Text(
                                          data.description,
                                          style: GoogleFonts.montserrat(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 2.w,
                                        right: 3.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "assets/images/HourglassSimpleMedium.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Offer Valid Till",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    13.sp)),
                                                    Text("Dec 22",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    13.sp))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Container(
                                                  height: 14,
                                                  child: Image.asset(
                                                    "assets/images/info-vector.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            })
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(),
                        gradient: LinearGradient(
                          begin: Alignment(-0.934, -1),
                          end: Alignment(1.125, 1.333),
                          colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
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
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Get.to(AddOffers(
                            shopId: shopId,
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(
                              '  Add new offer',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2110513051,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
