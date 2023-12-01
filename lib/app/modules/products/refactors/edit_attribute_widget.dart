import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/products/controllers/products_controller.dart';
import 'package:wonder_app/app/modules/products/views/products_view.dart';

class EditAttributeWidget extends StatelessWidget {
  const EditAttributeWidget({
    super.key,
    required this.attributesList,
  });
  final RxList attributesList;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productsController.controllers.length,
          itemBuilder: (contsext, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(7)),
              child: FutureBuilder(
                  future: productsController.getAllAttribute(),
                  builder: (constext, snap) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attribute",
                            style: GoogleFonts.roboto(fontSize: 12),
                          ),
                          Container(
                              height: 35,
                              child: Obx(() {
                                return DropdownButtonFormField(
                                  items: attributesList.map((data) {
                                    return DropdownMenuItem(
                                        value: data.id,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Text(
                                            data.title,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    // productsController
                                    //     .getIdOfAttributes(
                                    //         value, index);
                                    productsController.editAttributeId = value;
                                  },
                                );
                              })),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "value",
                                      style: GoogleFonts.roboto(fontSize: 12),
                                    ),
                                    Container(
                                        height: 35,
                                        child: TextField(
                                          controller: productsController
                                              .editValueAttributeController,
                                          onChanged: (value) {
                                            // String
                                            //     selectedAttributeId =
                                            //     productsController
                                            //         .idOfAttribute[
                                            //             index]
                                            //             ["id"]
                                            //         .toString();
                                            // // Call the function to add the id and value to the list
                                            // productsController
                                            //     .addIdAndValue(
                                            //         selectedAttributeId,
                                            //         value);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quantity",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  Container(
                                      height: 35,
                                      child: TextField(
                                        controller: productsController
                                            .editQuantityAttributeController,
                                        onChanged: (value) {},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: GoogleFonts.roboto(fontSize: 12),
                                    ),
                                    Container(
                                        height: 35,
                                        child: TextField(
                                          controller: productsController
                                              .editAttributePriceEditingController,
                                          onChanged: (value) {},
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discount",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  Container(
                                      height: 35,
                                      child: TextField(
                                        controller: productsController
                                            .editAttributeDiscountEditingController,
                                        onChanged: (value) {},
                                      )),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<ProductsController>(builder: (c) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: c.attributeImage != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            Base64Decoder()
                                                .convert(c.attributeImage),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            c.showPopup(context, "Attribute",
                                                attriubte: true);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
                                                color: Color.fromARGB(
                                                    255, 125, 129, 234),
                                              ),
                                              Text("Add Image")
                                            ],
                                          ),
                                        ),
                                ),
                                Visibility(
                                  visible:
                                      c.attributeImage == "" ? false : true,
                                  child: InkWell(
                                    onTap: () {
                                      c.removeImage(value: true);
                                    },
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Color.fromARGB(255, 227, 58, 46),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        ],
                      ),
                    );
                  }),
            );
          });
    });
  }
}
