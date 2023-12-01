import 'dart:convert';
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/products/extra/add_attribute.dart';
import 'package:wonder_app/app/modules/products/extra/buttons/add_attribute_button.dart';
import 'package:wonder_app/app/modules/products/refactors/edit_attribute_widget.dart';

import '../controllers/products_controller.dart';
import '../views/products_view.dart';
import 'add_products_view.dart';
import 'buttons/add_button.dart';

class EditProductDetails extends StatefulWidget {
  EditProductDetails({super.key, this.id});
  final dynamic id;

  @override
  State<EditProductDetails> createState() => _EditProductDetailsState();
}

class _EditProductDetailsState extends State<EditProductDetails> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController priceEditingController = TextEditingController();

  final TextEditingController skuEditingController = TextEditingController();

  final TextEditingController editQuantityEditingController =
      TextEditingController();

  final TextEditingController descriptionEditingController =
      TextEditingController();

  final TextEditingController taxEditingController = TextEditingController();

  final TextEditingController discountController = TextEditingController();

  final TextEditingController tagsController = TextEditingController();
  final TextEditingController deliveryChargeController =
      TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  dynamic editTaxType;

  dynamic editDiscountType;

  dynamic editCatId;

  dynamic editSubCatId;

  dynamic editReturnAvailability;
  dynamic deliveryTypeId;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      child: WillPopScope(
        onWillPop: () {
          productsController.listCount.value = 0;
          productsController.editControllers.clear();
          productsController.subCategoryLists.clear();
          productsController.editAttributesList.clear();
          Get.back();
          throw Exception();
        },
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
                      productsController.listCount.value = 0;
                      productsController.editControllers.clear();
                      productsController.subCategoryLists.clear();
                      productsController.editAttributesList.clear();
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
              'Edit ',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: FutureBuilder(
              future: productsController.getProductDetails(widget.id),
              builder: (contexts, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = productsController.editProductsList.first;
                nameEditingController.text = data.name;
                descriptionEditingController.text = data.shortDescription;
                priceEditingController.text = data.price;
                productsController.editQuantityEditingController.text =
                    data.quantity;
                discountController.text = data.discount;
                tagsController.text = data.tags;
                deliveryChargeController.text = data.deliveryCharge.toString();
                deliveryTypeId = data.deliveryType;
                netWeightController.text = data.productWeight;
                // taxEditingController.text = data.tax;
                // editTaxType = data.taxType == "null" ? null : data.taxType;
                editCatId = data.categoryId;
                // productsController.editCalculateCommission(editCatId);
                editSubCatId = data.subCategoryId;
                editDiscountType =
                    data.discountType == "null" ? null : data.discountType;
                editReturnAvailability = data.returnAvailablility == false
                    ? "Not-Available"
                    : "Available";
                return Obx(() {
                  return ListView.builder(
                      itemCount: productsController.editProductsList.length,
                      itemBuilder: (contexts, index) {
                        log(productsController
                            .editProductsList[index].attributes.length
                            .toString());
                        for (var i = 0;
                            i <
                                productsController
                                    .editProductsList[index].attributes.length;
                            i++) {
                          productsController.editControllers
                              .add(TextEditingController());
                          productsController.editControllers[i].text =
                              productsController
                                  .editProductsList[index].attributes[i].value;
                        }

                        productsController.editIdOfReturn = data.reasonIds
                            .map((item) => int.tryParse(item.id.toString()))
                            .where((value) => value != null)
                            .map((value) =>
                                value!) // Convert nullable int to non-nullable
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0, left: 4.w, right: 4.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(117, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      right: 4.w,
                                      left: 4.w,
                                      bottom: 20),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Title",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                              controller: nameEditingController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter value';
                                                }
                                                return null;
                                              },
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Short Description",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                controller:
                                                    descriptionEditingController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Selling Price",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                controller:
                                                    priceEditingController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Quantity",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                controller: productsController
                                                    .editQuantityEditingController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Tags",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                controller: tagsController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),

                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Delivery Charge",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    deliveryChargeController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Net-Weight",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35,
                                            child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: netWeightController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter value';
                                                  }
                                                  return null;
                                                })),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Column(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text(
                                        //             "Tax",
                                        //             style: GoogleFonts.roboto(
                                        //                 fontSize: 12),
                                        //           ),
                                        //           Container(
                                        //               height: 35,
                                        //               child: TextFormField(
                                        //                 controller:
                                        //                     taxEditingController,
                                        //               )),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 20),
                                        //     Expanded(
                                        //       child: Column(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text(
                                        //             "Tax Type",
                                        //             style: GoogleFonts.roboto(
                                        //                 fontSize: 12),
                                        //           ),
                                        //           Container(
                                        //               height: 35,
                                        //               child:
                                        //                   DropdownButtonFormField(
                                        //                 value: editTaxType,
                                        //                 items: productsController
                                        //                     .typeList
                                        //                     .map((data) {
                                        //                   return DropdownMenuItem(
                                        //                       value: data,
                                        //                       child: Padding(
                                        //                         padding:
                                        //                             const EdgeInsets
                                        //                                     .only(
                                        //                                 bottom:
                                        //                                     5.0),
                                        //                         child: Text(
                                        //                           data,
                                        //                           overflow:
                                        //                               TextOverflow
                                        //                                   .visible,
                                        //                         ),
                                        //                       ));
                                        //                 }).toList(),
                                        //                 onChanged: (value) {
                                        //                   editTaxType = value;
                                        //                 },
                                        //               )),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Discount",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12),
                                                  ),
                                                  Container(
                                                      height: 35,
                                                      child: TextFormField(
                                                          controller:
                                                              discountController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please enter value';
                                                            }
                                                            return null;
                                                          })),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Discount Type",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 12),
                                                  ),
                                                  Container(
                                                      height: 35,
                                                      child:
                                                          DropdownButtonFormField(
                                                              value:
                                                                  editDiscountType,
                                                              items:
                                                                  productsController
                                                                      .typeList
                                                                      .map(
                                                                          (data) {
                                                                return DropdownMenuItem(
                                                                    value: data,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              5.0),
                                                                      child:
                                                                          Text(
                                                                        data,
                                                                        overflow:
                                                                            TextOverflow.visible,
                                                                      ),
                                                                    ));
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                editDiscountType =
                                                                    value;
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    null) {
                                                                  return 'Please enter value';
                                                                }
                                                                return null;
                                                              })),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            FutureBuilder(
                                                future: productsController
                                                    .getCategories(),
                                                builder: (constext, snap) {
                                                  return Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Category",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12),
                                                        ),
                                                        Container(
                                                            height: 35,
                                                            child: Obx(() {
                                                              return DropdownButtonFormField(
                                                                  value:
                                                                      editCatId,
                                                                  items: productsController
                                                                      .categoryLists
                                                                      .map(
                                                                          (data) {
                                                                    return DropdownMenuItem(
                                                                        value: data
                                                                            .id,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 5.0),
                                                                          child:
                                                                              Text(
                                                                            data.name,
                                                                            overflow:
                                                                                TextOverflow.visible,
                                                                          ),
                                                                        ));
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (value) {
                                                                    editCatId =
                                                                        value;

                                                                    productsController
                                                                        .editCalculateCommission(
                                                                            value);
                                                                    productsController
                                                                        .getSubCategory(
                                                                            value);
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                        null) {
                                                                      return 'Please enter value';
                                                                    }
                                                                    return null;
                                                                  });
                                                            })),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                            Obx(() {
                                              return Visibility(
                                                visible: productsController
                                                            .editCommission
                                                            .value ==
                                                        "0"
                                                    ? false
                                                    : true,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Commission",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                productsController
                                                                    .editSelectQuantity(
                                                                        false);
                                                              },
                                                              child: Icon(
                                                                (Icons.remove),
                                                              )),
                                                          const SizedBox(
                                                              width: 5),
                                                          Container(
                                                            height: 20,
                                                            width: 30,
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Obx(() {
                                                                return Text(
                                                                  productsController
                                                                      .editQuantityVal
                                                                      .value
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          InkWell(
                                                              onTap: () {
                                                                productsController
                                                                    .editSelectQuantity(
                                                                        true);
                                                              },
                                                              child: Icon(
                                                                (Icons.add),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Sub-Category",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Container(
                                                height: 35,
                                                child: Obx(() {
                                                  return DropdownButtonFormField(
                                                    value: editSubCatId,
                                                    items: productsController
                                                        .subCategoryLists
                                                        .map((data) {
                                                      return DropdownMenuItem(
                                                          value: data.id,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                        5.0),
                                                            child: Text(
                                                              data.name,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                          ));
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      editSubCatId = value;
                                                    },
                                                  );
                                                })),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivery type",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Container(
                                                height: 35,
                                                child: DropdownButtonFormField(
                                                  value: deliveryTypeId,
                                                  items: productsController
                                                      .deliveryTypeList
                                                      .map((data) {
                                                    return DropdownMenuItem(
                                                        value: data,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 5.0),
                                                          child: Text(
                                                            data,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    deliveryTypeId = value;
                                                  },
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),

                                        Obx(() {
                                          return ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final data = productsController
                                                    .editAttributesList[index];
                                                return Container(
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    gradient: LinearGradient(
                                                        begin: Alignment(
                                                            1.4153012037277222,
                                                            0.15562866628170013),
                                                        end: Alignment(-0.15562868118286133, 0.044075123965740204),
                                                        colors: [
                                                          Color.fromRGBO(213,
                                                              210, 210, 0.749),
                                                          Color.fromRGBO(223,
                                                              222, 222, 0.678)
                                                        ]),
                                                  ),
                                                  child: ListTile(
                                                    leading: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: data.fileImage !=
                                                              null
                                                          ? Image.memory(
                                                              Base64Decoder()
                                                                  .convert(data
                                                                      .fileImage))
                                                          : data.image != null
                                                              ? Image.network(
                                                                  "$baseUrlForImage${data.image}")
                                                              : Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .apps),
                                                                  ],
                                                                ),
                                                    ),
                                                    title: Text(
                                                        "Attribute : ${data.value}"),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "Quantity: ${data.quantity}"),
                                                        Text(
                                                            "Price: ${data.price}")
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              // data.id != null
                                                              //     ? productsController
                                                              //         .deleteAttribute(
                                                              //             data.id,
                                                              //             widget
                                                              //                 .id)
                                                              //     : productsController
                                                              //         .removeEditAttributeFromList(
                                                              //             index,
                                                              //             data.quantity);

                                                              productsController.attributeEditDialogBox(
                                                                  data.id,
                                                                  id: widget.id,
                                                                  index: index,
                                                                  productId:
                                                                      widget.id,
                                                                  context:
                                                                      context,
                                                                  attributeId: data
                                                                      .attributeId,
                                                                  discount: data
                                                                      .discount
                                                                      .toString(),
                                                                  price: data
                                                                      .price
                                                                      .toString(),
                                                                  quantity: data
                                                                      .quantity
                                                                      .toString(),
                                                                  value: data
                                                                      .value
                                                                      .toString());
                                                            },
                                                            icon: Icon(
                                                                Icons.edit)),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              itemCount: productsController
                                                  .editAttributesList.length);
                                        }),

                                        SizedBox(
                                          height: 15,
                                        ),
                                        // EditAttributeWidget(
                                        //     attributesList: productsController
                                        //         .attributeLists),
                                        // SizedBox(
                                        //   height: 15,
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.end,
                                        //   children: [
                                        //     AddButton(
                                        //         onClick: () {
                                        //           // productsController
                                        //           //     .listCount.value++;
                                        //           // productsController
                                        //           //     .editAttributesList
                                        //           //     .add(EditAttribute(
                                        //           //         id: null,
                                        //           //         attributeId: null,
                                        //           //         attribute: null,
                                        //           //         value: ""));
                                        //           // productsController
                                        //           //     .editControllers
                                        //           //     .add(
                                        //           //         TextEditingController());
                                        //           // log(productsController
                                        //           //     .editAttributesList
                                        //           //     .toString());
                                        //           productsController
                                        //               .editAttributeToList();
                                        //         },
                                        //         productsController:
                                        //             productsController),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: 25,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AddAttributeButton(
                              productsController: productsController,
                              productId: data.id,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 4.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(117, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      right: 4.w,
                                      left: 4.w,
                                      bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Return",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 15),
                                      NameAndDropDown(
                                          productsController:
                                              productsController,
                                          name: "Return Availability",
                                          value: editReturnAvailability,
                                          ontap: (p0) {
                                            log(p0.toString());
                                            productsController
                                                .returnAvailability = p0;
                                          },
                                          dropDownList: productsController
                                              .availabilityList),
                                      SizedBox(height: 15),
                                      FutureBuilder(
                                          future:
                                              productsController.getAllReturn(),
                                          builder: (constext, snap) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Return Reasons",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                GetBuilder<ProductsController>(
                                                    builder: (cont) {
                                                  return Container(
                                                      child:
                                                          MultiSelectDialogField(
                                                    isDismissible: true,
                                                    listType:
                                                        MultiSelectListType
                                                            .CHIP,
                                                    items: productsController
                                                        .returnReasons,
                                                    title:
                                                        Text('Select Options'),
                                                    selectedItemsTextStyle:
                                                        TextStyle(
                                                            color:
                                                                Colors.white),
                                                    selectedColor:
                                                        Color.fromARGB(
                                                            255, 170, 86, 177),
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                                255,
                                                                167,
                                                                54,
                                                                178)
                                                            .withOpacity(0.1)),
                                                    buttonText: Text('Select'),
                                                    initialValue:
                                                        productsController
                                                            .editIdOfReturn,
                                                    onConfirm: (selectedItems) {
                                                      // Handle selected items

                                                      productsController
                                                          .getEditIdOfReturns(
                                                              selectedItems);
                                                      print(
                                                          'Selected Items: $selectedItems');
                                                    },
                                                  ));
                                                }),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 4.w,
                                top: 15,
                              ),
                              child: Text("Product Image"),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 8.w, bottom: 20),
                            //   child:
                            //       GetBuilder<ProductsController>(builder: (c) {
                            //     return Row(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Container(
                            //           width: 30.w,
                            //           height: 120,
                            //           decoration: BoxDecoration(
                            //               border:
                            //                   Border.all(color: Colors.grey),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //               color: Colors.white),
                            //           child: c.editImage != ""
                            //               ? InkWell(
                            //                   onTap: () {
                            //                     c.showPopup(context, "Edit");
                            //                   },
                            //                   child: ClipRRect(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10),
                            //                     child: Image.memory(
                            //                       Base64Decoder()
                            //                           .convert(c.editImage),
                            //                       fit: BoxFit.cover,
                            //                     ),
                            //                   ),
                            //                 )
                            //               : data.featuredImage.isNotEmpty
                            //                   ? InkWell(
                            //                       onTap: () {
                            //                         c.showPopup(
                            //                             context, "Edit");
                            //                       },
                            //                       child: ClipRRect(
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                                 10),
                            //                         child: Image.network(
                            //                           "$baseUrlForImage${data.featuredImage}",
                            //                           fit: BoxFit.cover,
                            //                         ),
                            //                       ),
                            //                     )
                            //                   : InkWell(
                            //                       onTap: () {
                            //                         c.showPopup(
                            //                             context, "Edit");
                            //                       },
                            //                       child: Center(
                            //                         child: Icon(
                            //                           Icons
                            //                               .add_circle_outline_outlined,
                            //                           color: Color.fromARGB(
                            //                               255, 125, 129, 234),
                            //                         ),
                            //                       ),
                            //                     ),
                            //         ),
                            //         Visibility(
                            //           visible: c.editImage == "" ? false : true,
                            //           child: InkWell(
                            //             onTap: () {
                            //               c.removeImage();
                            //             },
                            //             child: Icon(
                            //               Icons.remove_circle,
                            //               color:
                            //                   Color.fromARGB(255, 227, 58, 46),
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     );
                            //   }),
                            // ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Obx(() {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: SizedBox(
                                    width: 100.w,
                                    // To show images in particular area only
                                    child: productsController.imageList
                                            .isEmpty // If no images is selected
                                        ? Center(
                                            child: Text(
                                                'Sorry nothing selected!!'.tr))
                                        // If atleast 1 images is selected
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: productsController
                                                    .imageList.length +
                                                1,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 0,
                                              // mainAxisSpacing: 5
                                              // Horizontally only 3 images will show
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // TO show selected file
                                              if (index <
                                                  productsController
                                                      .imageList.length) {
                                                return Container(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                            top: 8,
                                                            left: 0,
                                                            child: Container(
                                                                width: 24.w,
                                                                height: 100,
                                                                child: Stack(
                                                                    children: <Widget>[
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child: productsController.imageList[index].id ==
                                                                                null
                                                                            ? Image.file(
                                                                                productsController.imageList[index].image,
                                                                                fit: BoxFit.contain,
                                                                              )
                                                                            : Image.network(
                                                                                "$baseUrlForImage${productsController.imageList[index].image}",
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                      ),
                                                                    ]))),
                                                        Positioned(
                                                          top: 0,
                                                          left: 80,
                                                          child: InkWell(
                                                              onTap: () {
                                                                productsController.deleteImageFromList(
                                                                    productsController
                                                                        .imageList[
                                                                            index]
                                                                        .id,
                                                                    widget.id,
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
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        top: 8,
                                                        left: 0,
                                                        child: Container(
                                                          width: 22.w,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                productsController
                                                                    .selectMultipleImages(
                                                                        false);
                                                              },
                                                              icon: Icon(Icons
                                                                  .add_a_photo)),
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
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 40,
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
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Obx(() {
                                            return ElevatedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors
                                                                .transparent)),
                                                onPressed: productsController
                                                        .editLoading.value
                                                    ? null
                                                    : () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          productsController.editProductDetails(
                                                              context: context,
                                                              tags: tagsController.text
                                                                  .toString(),
                                                              categoryId: editCatId
                                                                  .toString(),
                                                              discType: editDiscountType
                                                                  .toString(),
                                                              discount:
                                                                  discountController.text
                                                                      .toString(),
                                                              name: nameEditingController
                                                                  .text
                                                                  .toString(),
                                                              price: priceEditingController
                                                                  .text
                                                                  .toString(),
                                                              productId: widget.id
                                                                  .toString(),
                                                              quantity: productsController
                                                                  .editQuantityEditingController
                                                                  .text
                                                                  .toString(),
                                                              shortDescription:
                                                                  descriptionEditingController
                                                                      .text
                                                                      .toString(),
                                                              subCatId: editSubCatId
                                                                  .toString(),
                                                              deliveryCharge:
                                                                  deliveryChargeController
                                                                      .text
                                                                      .toString(),
                                                              deliveryType:
                                                                  deliveryTypeId
                                                                      .toString(),
                                                              netWeight:
                                                                  netWeightController
                                                                      .text
                                                                      .toString()
                                                              // tax:
                                                              //     taxEditingController
                                                              //         .text
                                                              //         .toString(),
                                                              // taxType: editTaxType
                                                              //     .toString()
                                                              );
                                                        } else {
                                                          Get.snackbar("Error",
                                                              "Please Check All Fields",
                                                              backgroundColor:
                                                                  Colors.red);
                                                        }
                                                      },
                                                child: productsController
                                                        .editLoading.value
                                                    ? Row(
                                                        children: [
                                                          CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                          Text("  Processing",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      color: Colors
                                                                          .white))
                                                        ],
                                                      )
                                                    : Text(
                                                        "Update",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white),
                                                      ));
                                          }))),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                });
              }),
        ),
      ),
    );
  }
}
