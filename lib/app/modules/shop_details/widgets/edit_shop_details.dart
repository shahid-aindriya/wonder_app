import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/my_shops/model/shops_list_model.dart';

import '../../../data/urls.dart';

class EditShopDetails extends StatelessWidget {
  ShopDatum? data;
  EditShopDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final TextEditingController shopNameController =
        TextEditingController(text: data!.name);
    final TextEditingController shopAdressController =
        TextEditingController(text: data!.address);
    final TextEditingController shopLocationController =
        TextEditingController(text: data!.location);
    final TextEditingController shopCategoryController =
        TextEditingController(text: data!.category);
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
            'Edit Basic Details',
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
                        image: NetworkImage("$baseUrl${data!.featuredImage}"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 45,
                        height: 34,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Color.fromARGB(255, 144, 149, 255),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.h, left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Shop Name",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: shopNameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Shop Address",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: shopAdressController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Location",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: shopLocationController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Category",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: shopCategoryController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 124,
                        height: 48,
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0)),
                          onPressed: () async {},
                          child: Text(
                            'Save',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.2110513051,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
