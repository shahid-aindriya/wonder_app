import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/my_shops/controllers/my_shops_controller.dart';
import 'package:wonder_app/app/modules/my_shops/model/shops_list_model.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/edit_shop_details.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/shop_gst_details.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/shop_license_details.dart';
import 'package:wonder_app/app/modules/shop_details/widgets/shop_offers.dart';

import '../controllers/shop_details_controller.dart';
import '../widgets/bank_details.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  final MyShopsController? shopController;
  ShopDatum? data;
  ShopDetailsView({Key? key, this.data, this.shopController}) : super(key: key);
  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());
  @override
  Widget build(BuildContext context) {
    shopDetailsController.shopId = data!.id;

    shopDetailsController.getOffers();
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
                                        shopController: shopController!,
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
                                          width: 13.w,
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
                              onPressed: () {
                                Get.to(ShopOffers(
                                  controller: shopDetailsController,
                                  shopId: data!.id,
                                ));
                              },
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
                              onPressed: () {
                                Get.to(ShopLicenseDetails(
                                  image: data!.licenseImage,
                                  licence: data!.licenseNumber,
                                ));
                              },
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
                              onPressed: () {
                                Get.to(ShopGstDetails(
                                  gst: data!.gstNumber,
                                  image: data!.gstImage,
                                ));
                              },
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
                              onPressed: () {
                                log(data!.id.toString());

                                Get.to(() => BankDetailsOfShop(
                                      shopId: data!.id,
                                      data: data!.bankData,
                                      accounType: data!.bankData.accountType,
                                      accountNumber:
                                          data!.bankData.accountNumber,
                                      holderName: data!.bankData.name,
                                      ifscCode: data!.bankData.ifscCode,
                                      image: data!.bankData.chequeCopy,
                                      bankId: data!.bankData.bankId,
                                    ));
                                // Get.to(BankDetailsOfShop(
                                //   shopId: data!.id,
                                //   data: data!.bankData,
                                //   accounType: data!.bankData.accountType,
                                //   accountNumber: data!.bankData.accountNumber,
                                //   holderName: data!.bankData.name,
                                //   ifscCode: data!.bankData.ifscCode,
                                //   image: data!.bankData.chequeCopy,
                                //   bankId: data!.bankData.bankId,
                                // ));
                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    ),

                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.all(
                    //             Color.fromARGB(255, 196, 38, 27))),
                    //     onPressed: () {
                    //       shopDetailsController.deleteShop(
                    //           bankid: data!.bankData.bankId,
                    //           controller: shopController,
                    //           context: context);
                    //     },
                    //     child: Text("Delete Shop")),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
