import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/products/controllers/attribute_controller.dart';
import 'package:wonder_app/app/modules/products/views/products_view.dart';

class EditSingleAttribute extends StatelessWidget {
  EditSingleAttribute({super.key, this.attributeId, this.productId});
  final attributeId;
  final productId;
  final AttributeController attributeController =
      Get.put(AttributeController());
  final TextEditingController valueEditingController = TextEditingController();
  final TextEditingController quantityEditingController =
      TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController discountEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        attributeController.imageEditList.clear();
        Get.back();
        throw Exception();
      },
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
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(117, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        attributeController.imageEditList.clear();

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
                'Edit Attribute',
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
                  padding: EdgeInsets.only(
                      top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(141, 255, 255, 255),
                        borderRadius: BorderRadius.circular(7)),
                    child: FutureBuilder(
                        future: attributeController
                            .getAttributeDetails(attributeId),
                        builder: (constext, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          }

                          return Obx(() {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: attributeController
                                    .singleAttributeDetailsList.length,
                                itemBuilder: (context, index) {
                                  final data = attributeController
                                      .singleAttributeDetailsList.first;
                                  valueEditingController.text = data.value;
                                  attributeController.editAttributeId =
                                      data.attributeId;
                                  quantityEditingController.text =
                                      data.quantity;
                                  priceEditingController.text = data.price;
                                  discountEditingController.text =
                                      data.discount;
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(top: 20.0, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.w, right: 4.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Attribute",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12),
                                              ),
                                              FutureBuilder(
                                                  future: productsController
                                                      .getAllAttribute(),
                                                  builder: (context, snapshot) {
                                                    return Container(
                                                        height: 35,
                                                        child: Obx(() {
                                                          return DropdownButtonFormField(
                                                            value: attributeController
                                                                .editAttributeId,
                                                            items: productsController
                                                                .attributeLists
                                                                .map((data) {
                                                              return DropdownMenuItem(
                                                                  value:
                                                                      data.id,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            5.0),
                                                                    child: Text(
                                                                      data.title,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                    ),
                                                                  ));
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              log(value
                                                                  .toString());
                                                              attributeController
                                                                  .selectFromDropDown(
                                                                      value);
                                                            },
                                                          );
                                                        }));
                                                  }),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "value",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12),
                                                        ),
                                                        Container(
                                                            height: 35,
                                                            child: TextField(
                                                              controller:
                                                                  valueEditingController,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Quantity",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
                                                      ),
                                                      Container(
                                                          height: 35,
                                                          child: TextField(
                                                            controller:
                                                                quantityEditingController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged:
                                                                (value) {},
                                                          )),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Price",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12),
                                                        ),
                                                        Container(
                                                            height: 35,
                                                            child: TextField(
                                                              controller:
                                                                  priceEditingController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {},
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Discount",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
                                                      ),
                                                      Container(
                                                          height: 35,
                                                          child: TextField(
                                                            controller:
                                                                discountEditingController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          )),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Obx(() {
                                            return SizedBox(
                                              width: 100.w,
                                              // To show images in particular area only
                                              child: attributeController
                                                      .attributeImageList
                                                      .isEmpty // If no images is selected
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 4.w,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            5),
                                                                child: Text(
                                                                    "Select Images"),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 22.w,
                                                                height: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white),
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          attributeController.showPopup(
                                                                              context,
                                                                              false);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.add_a_photo)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  // If atleast 1 images is selected
                                                  : GridView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: attributeController
                                                              .attributeImageList
                                                              .length +
                                                          1,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 0,
                                                        // mainAxisSpacing: 5
                                                        // Horizontally only 3 images will show
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        // TO show selected file
                                                        if (index <
                                                            attributeController
                                                                .attributeImageList
                                                                .length) {
                                                          return Container(
                                                              child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 4.w),
                                                            child: Stack(
                                                                children: <Widget>[
                                                                  Positioned(
                                                                      top: 8,
                                                                      left: 0,
                                                                      child: Container(
                                                                          width: 24.w,
                                                                          height: 100,
                                                                          child: Stack(children: <Widget>[
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: attributeController.attributeImageList[index].id == null
                                                                                  ? Image.file(
                                                                                      attributeController.attributeImageList[index].image,
                                                                                      fit: BoxFit.contain,
                                                                                    )
                                                                                  : Image.network("$baseUrlForImage/${attributeController.attributeImageList[index].image}"),
                                                                            ),
                                                                          ]))),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          attributeController.removeAttributeImage(
                                                                              attributeController.attributeImageList[index].id,
                                                                              attributeId,
                                                                              context,
                                                                              index);
                                                                        },
                                                                        child: Icon(
                                                                          Icons
                                                                              .remove_circle_outline,
                                                                          color:
                                                                              Colors.red,
                                                                        )),
                                                                  ),
                                                                ]),
                                                          ));
                                                        }
                                                        return Container(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 4.w),
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  top: 8,
                                                                  left: 0,
                                                                  child:
                                                                      Container(
                                                                    width: 22.w,
                                                                    height: 100,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .white),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          attributeController.showPopup(
                                                                              context,
                                                                              false);
                                                                        },
                                                                        icon: Icon(Icons.add_a_photo)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                        // If you are making the web app then you have to
                                                        // use image provider as network image or in
                                                        // android or iOS it will as file only
                                                      },
                                                    ),
                                            );
                                          }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border(),
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment(-0.934, -1),
                                                    end:
                                                        Alignment(1.125, 1.333),
                                                    colors: <Color>[
                                                      Color(0xe53f46bd),
                                                      Color(0xe5417de8)
                                                    ],
                                                    stops: <double>[0, 1],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x3f000000),
                                                      offset: Offset(
                                                          0, 0.7870440483),
                                                      blurRadius: 2.7546541691,
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(0),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .transparent)),
                                                    onPressed: () {
                                                      attributeController.updateAttribute(
                                                          attributeId:
                                                              attributeId,
                                                          context: context,
                                                          discount:
                                                              discountEditingController
                                                                  .text,
                                                          id: attributeId,
                                                          price:
                                                              priceEditingController
                                                                  .text,
                                                          quantity:
                                                              quantityEditingController
                                                                  .text,
                                                          value:
                                                              valueEditingController
                                                                  .text);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Update Attribute",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ))),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          });
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
