import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/shop_details/views/shop_details_view.dart';
import 'package:wonder_app/app/modules/store_details/views/store_details_view.dart';

import '../controllers/my_shops_controller.dart';

class MyShopsView extends GetView<MyShopsController> {
  final MyShopsController shopController = Get.put(MyShopsController());
  MyShopsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    shopController.getListOfShops();
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
            'My Shops',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => shopController.getListOfShops(),
          child: ListView(
            children: [
              Obx(() {
                return shopController.shopLists.isEmpty
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
                                Lottie.asset(
                                    "assets/images/13659-no-data.json"),
                              ],
                            ),
                          ),
                        ],
                      )
                    : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: shopController.shopLists.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: .77),
                        itemBuilder: (context, index) {
                          var data = shopController.shopLists[index];
                          String myString = data.address;
                          String location = data.address.length > 30
                              ? myString.substring(0, 30)
                              : data.address;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: InkWell(
                                onTap: () async {
                                  final box = FlutterSecureStorage();
                                  await box.write(
                                      key: "shopId", value: data.id.toString());

                                  Get.to(ShopDetailsView(
                                    shopController: shopController,
                                    data: data,
                                  ));
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Container(
                                              width: 100.w,
                                              height: 18.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16)),
                                                child: data
                                                        .featuredImage.isEmpty
                                                    ? Image.asset(
                                                        "assets/images/User.png")
                                                    : Image.network(
                                                        "$baseUrlForImage${data.featuredImage}",
                                                        fit: BoxFit.fill,
                                                      ),
                                              )

                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.all(0.0),
                                              //   child: Row(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.end,
                                              //     children: [
                                              //       // Figma Flutter Generator Rectangle33Widget - RECTANGLE
                                              //       // IconButton(
                                              //       //     onPressed: () {},
                                              //       //     icon: Icon(
                                              //       //       Icons.favorite,
                                              //       //       color: Colors.grey,
                                              //       //     ))
                                              //     ],
                                              //   ),
                                              // )

                                              ),
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${data.name} ,",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                location,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/textile_vector.png"),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              data.category,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        // GetBuilder<MyShopsController>(
                                        //     builder: (context1) {
                                        //   return Row(
                                        //     children: [
                                        //       StarRating(
                                        //           starSize: 18,
                                        //           color: Color.fromARGB(
                                        //               255, 240, 188, 3),
                                        //           length: 5,
                                        //           rating: shopController
                                        //               .rating1[index],
                                        //           onRaitingTap: (rating) {
                                        //             shopController.starRating(
                                        //                 index, rating);
                                        //           }),
                                        //       Text(
                                        //         " (125)",
                                        //         style: GoogleFonts.roboto(
                                        //             fontSize: 14.sp,
                                        //             fontWeight:
                                        //                 FontWeight.w300),
                                        //       )
                                        //     ],
                                        //   );
                                        // }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              })
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 45.w,
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
                      Get.to(StoreDetailsView());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          '  Add Shops',
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
        ),
      ),
    );
  }
}
