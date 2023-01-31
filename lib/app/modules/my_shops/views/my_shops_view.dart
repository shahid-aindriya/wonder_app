import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:star_rating/star_rating.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/shop_details/views/shop_details_view.dart';

import '../controllers/my_shops_controller.dart';

class MyShopsView extends GetView<MyShopsController> {
  final MyShopsController shopController = Get.put(MyShopsController());
  MyShopsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.png"),
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
            title: Text(
              'My Shops',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: ListView(
            children: [
              FutureBuilder(
                  future: shopController.getListOfShops(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: shopController.shopLists.value.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .77),
                      itemBuilder: (context, index) {
                        var data = shopController.shopLists.value[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(ShopDetailsView(
                                            data: data,
                                          ));
                                        },
                                        child: Container(
                                            width: 100.w,
                                            height: 18.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: NetworkImage(
                                                "$baseUrl${data.featuredImage}",
                                              ),
                                              fit: BoxFit.fitWidth,
                                            )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // Figma Flutter Generator Rectangle33Widget - RECTANGLE
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: Colors.grey,
                                                      ))
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    Text(
                                      "${data.name} ,",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      data.location,
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500),
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
                                    GetBuilder<MyShopsController>(
                                        builder: (context1) {
                                      return Row(
                                        children: [
                                          StarRating(
                                              starSize: 18,
                                              color: Color.fromARGB(
                                                  255, 240, 188, 3),
                                              length: 5,
                                              rating:
                                                  shopController.rating1[index],
                                              onRaitingTap: (rating) {
                                                shopController.starRating(
                                                    index, rating);
                                              }),
                                          Text(
                                            " (125)",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
            ],
          )),
    );
  }
}
