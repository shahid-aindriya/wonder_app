import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/my_shops/model/shops_list_model.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/edit_shop_details.dart';

import '../controllers/shop_details_controller.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  ShopDatum? data;
  ShopDetailsView({Key? key, this.data}) : super(key: key);
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
              'Shop Details',
              style: GoogleFonts.roboto(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  height: 2,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
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
                        image: DecorationImage(
                            image:
                                NetworkImage("$baseUrl${data!.featuredImage}"),
                            fit: BoxFit.cover),
                      ))
                ],
              ), // Figma Flutter Generator Rectangle17Widget - RECTANGLE
              Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 20),
                child: Column(
                  children: [
                    Container(
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
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      Get.to(EditShopDetails(
                                        data: data,
                                      ));
                                    },
                                    icon: Icon(Icons.edit, size: 19),
                                    label: Text("Edit",
                                        style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.w,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text("Name"),
                                        SizedBox(
                                          width: 24.w,
                                        ),
                                        Text(data!.name,
                                            style: GoogleFonts.roboto(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text("Location"),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Flexible(
                                          child: Text(data!.location,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w400)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text("Address"),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Flexible(
                                          child: Text(data!.address,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w400)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text("Commission"),
                                        SizedBox(
                                          width: 22.w,
                                        ),
                                        Text("${data!.commission}%",
                                            style: GoogleFonts.roboto(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text("Category"),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Text(data!.category,
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

                    // Figma Flutter Generator Rectangle17Widget - RECTANGLE
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          title: Text("Offers",
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400)),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          title: Text("License Details",
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400)),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          title: Text("Gst Details",
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400)),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, bottom: 20),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          title: Text("Bank Details",
                              style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400)),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
