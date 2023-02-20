import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/my_shops/controllers/my_shops_controller.dart';
import 'package:wonder_app/app/modules/my_shops/model/shops_list_model.dart';
import 'package:wonder_app/app/modules/shop_details/controllers/shop_details_controller.dart';

import '../../../data/urls.dart';
import '../../map_place_picker/views/map_place_picker_view.dart';
import '../../store_details/views/store_details_view.dart';

class EditShopDetails extends StatelessWidget {
  ShopDatum? data;
  final MyShopsController shopController;
  EditShopDetails({super.key, this.data, required this.shopController});
  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());
  final formkey = GlobalKey<FormState>();
  @override
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dynamic lat = data!.latitude;
    dynamic long = data!.longitude;
    shopDetailsController.isChecked = data!.isFeatured;
    log(shopDetailsController.isChecked.toString());
    final TextEditingController shopNameController =
        TextEditingController(text: data!.name);
    final TextEditingController shopAdressController =
        TextEditingController(text: data!.address);
    final TextEditingController shopLocationController =
        TextEditingController(text: data!.location);
    final TextEditingController shopCommissionController =
        TextEditingController(text: data!.commission);
    final TextEditingController shopGstPctController =
        TextEditingController(text: data!.gstPct);
    final TextEditingController shopLicenceNumberController =
        TextEditingController(text: data!.licenseNumber);
    final TextEditingController shopGstNumberController =
        TextEditingController(text: data!.gstNumber);
    shopDetailsController.getShopCategories();

    shopDetailsController.categoryId = data!.categoryId.toString();
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
                GetBuilder<ShopDetailsController>(builder: (context) {
                  return Visibility(
                    visible:
                        shopDetailsController.shopImage == '' ? true : false,
                    child: Container(
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
                                onPressed: () {
                                  shopDetailsController.pickShopImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color.fromARGB(255, 144, 149, 255),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                GetBuilder<ShopDetailsController>(builder: (contesxt) {
                  return Visibility(
                    visible:
                        shopDetailsController.shopImage == '' ? false : true,
                    child: Container(
                      width: 45.w,
                      height: 45.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        image: DecorationImage(
                            image: MemoryImage(Base64Decoder()
                                .convert(shopDetailsController.shopImage)),
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
                                onPressed: () {
                                  shopDetailsController.pickShopImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color.fromARGB(255, 144, 149, 255),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
            Form(
              key: formkey,
              child: Padding(
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
                      validator: (value) {
                        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value!) ||
                            value.length < 3) {
                          return 'please enter valid name';
                        } else {
                          return null;
                        }
                      },
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
                      validator: (value) {
                        if (!RegExp(r'^[#.0-9a-zA-Z\u00C0-\u00FF ,]+$')
                                .hasMatch(value!) ||
                            value.length < 3) {
                          return 'please enter valid adress';
                        } else {
                          return null;
                        }
                      },
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
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              Get.to(MapPlacePickerView(),
                                  arguments: LocationDatas(
                                      lat: latController,
                                      location: shopLocationController,
                                      long: longController));
                            },
                            icon: Icon(Icons.my_location_sharp)),
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
                      onTap: () {
                        Get.to(MapPlacePickerView(),
                            arguments: LocationDatas(
                                lat: latController,
                                location: shopLocationController,
                                long: longController));
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid location';
                        } else {
                          return null;
                        }
                      },
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
                    DropdownButtonFormField(
                      isExpanded: true,
                      isDense: true,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
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
                      value: shopDetailsController.categoryId,
                      onChanged: (value) {
                        log(value.toString());
                      },
                      items:
                          shopDetailsController.categoryLists.value.map((data) {
                        return DropdownMenuItem(
                            value: data.id.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                data.name,
                                overflow: TextOverflow.visible,
                              ),
                            ));
                      }).toList(),
                      validator: (value) {
                        if (shopDetailsController.categoryId == null) {
                          return "Please Select category";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Commission",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: shopCommissionController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid location';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Gst-Percentage%",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: shopGstPctController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid location';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Licence Number",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: shopLicenceNumberController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid location';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Gst Number",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: shopGstNumberController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid location';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Gst Image",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<ShopDetailsController>(builder: (scontext) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                hintText: shopDetailsController.gstImage == ''
                                    ? "Browse Document"
                                    : "Uploaded",
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.circular(16)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              // validator: (value) {
                              //   if (!RegExp(r'^-?[0-9]+$')
                              //           .hasMatch(value!) ||
                              //       value.length < 3) {
                              //     return 'please enter valid email';
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
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
                              child: Center(
                                child: Text(
                                  'Upload',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2110513051,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Licence Image",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<ShopDetailsController>(builder: (scontext) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                hintText: shopDetailsController.gstImage == ''
                                    ? "Browse Document"
                                    : "Uploaded",
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.circular(16)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.3),
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              // validator: (value) {
                              //   if (!RegExp(r'^-?[0-9]+$')
                              //           .hasMatch(value!) ||
                              //       value.length < 3) {
                              //     return 'please enter valid email';
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
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
                              child: Center(
                                child: Text(
                                  'Upload',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2110513051,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 13,
                    ),
                    GetBuilder<ShopDetailsController>(builder: (context) {
                      return Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Checkbox(
                              checkColor: Color(0xff4956b2),
                              activeColor: Color.fromARGB(255, 255, 255, 255),
                              fillColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                              value: shopDetailsController.isChecked,
                              onChanged: (value) {
                                shopDetailsController.checkBox(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Set Featured",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.1725,
                                  color: Color(0xff4956b2)))
                        ],
                      );
                    }),
                  ],
                ),
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0)),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        shopDetailsController.editShopDetails(
                            context: context,
                            address: shopLocationController.text,
                            lat: lat,
                            long: long,
                            contorller: shopController,
                            shopId: data!.id,
                            commission: shopCommissionController.text,
                            gstNumber: shopGstNumberController.text,
                            gstPct: shopGstPctController.text,
                            licenceNumber: shopLicenceNumberController.text,
                            location: shopLocationController.text,
                            shopName: shopNameController.text);
                      }
                    },
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
      ),
    );
  }
}
