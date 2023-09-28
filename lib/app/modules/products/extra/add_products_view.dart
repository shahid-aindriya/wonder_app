import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/products_controller.dart';
import '../views/products_view.dart';
import 'buttons/add_button.dart';
import 'buttons/remove_button.dart';

class AddProductsView extends StatelessWidget {
  AddProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    productsController.deliveryTypeId = productsController.deliveryTypeList[0];
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
          // title: Text(
          //   'Chat List',
          //   style: GoogleFonts.jost(
          //     fontSize: 22,
          //     fontWeight: FontWeight.w500,
          //     color: Color(0xff4956b2),
          //   ),
          // ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 4.w, right: 4.w),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(117, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            controller:
                                productsController.nameEditingController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Short Description",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 40,
                          child: TextFormField(
                            maxLines: 1,
                            controller:
                                productsController.descriptionEditingController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Selling Price",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                productsController.priceEditingController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Quantity",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                productsController.quantityEditingController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tags",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            controller: productsController.tagsController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Delivery Charge",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                productsController.deliveryChargeController,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Net-Weight",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(
                          height: 35,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: productsController.netWeightController,
                          )),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // DropdownAndTextfield(
                      //   keyBoardType: TextInputType.number,
                      //   droDownList: productsController.typeList,
                      //   firstName: "Tax",
                      //   secondName: "Tax Type",
                      //   value: productsController.taxType,
                      //   textEditingController:
                      //       productsController.taxEditingController,
                      //   productsController: productsController,
                      //   ontap: (p0) {
                      //     productsController.taxType = p0;
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownAndTextfield(
                        keyBoardType: TextInputType.number,
                        droDownList: productsController.typeList,
                        firstName: "Discount",
                        secondName: "Discount Type",
                        value: productsController.discType,
                        textEditingController:
                            productsController.discountController,
                        productsController: productsController,
                        ontap: (p0) {
                          productsController.discType = p0;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          FutureBuilder(
                              future: productsController.getCategories(),
                              builder: (constext, snap) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Category",
                                        style: GoogleFonts.roboto(fontSize: 12),
                                      ),
                                      Container(
                                          height: 35,
                                          child: Obx(() {
                                            return DropdownButtonFormField(
                                              value: productsController.catId,
                                              items: productsController
                                                  .categoryLists
                                                  .map((data) {
                                                return DropdownMenuItem(
                                                    value: data.id,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5.0),
                                                      child: Text(
                                                        data.name,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ));
                                              }).toList(),
                                              onChanged: (value) {
                                                productsController.catId =
                                                    value;
                                                productsController
                                                    .getSubCategory(value);
                                                productsController
                                                    .calculateCommission(value);
                                              },
                                            );
                                          })),
                                    ],
                                  ),
                                );
                              }),
                          Obx(() {
                            return Visibility(
                              visible: productsController.commission.isEmpty
                                  ? false
                                  : true,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Commission",
                                      style: GoogleFonts.roboto(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              productsController
                                                  .selectQuantity(false);
                                            },
                                            child: Icon(
                                              (Icons.remove),
                                            )),
                                        const SizedBox(width: 5),
                                        Container(
                                          height: 20,
                                          width: 30,
                                          color: Colors.white,
                                          child: Center(
                                            child: Obx(() {
                                              return Text(
                                                productsController
                                                    .quantityVal.value
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                            onTap: () {
                                              productsController
                                                  .selectQuantity(true);
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
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sub-Category",
                            style: GoogleFonts.roboto(fontSize: 12),
                          ),
                          Container(
                              height: 35,
                              child: Obx(() {
                                return DropdownButtonFormField(
                                  value: productsController.subCatId,
                                  items: productsController.subCategoryLists
                                      .map((data) {
                                    return DropdownMenuItem(
                                        value: data.id,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Text(
                                            data.name,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    productsController.subCatId = value;
                                  },
                                );
                              })),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery type",
                            style: GoogleFonts.roboto(fontSize: 12),
                          ),
                          Container(
                              height: 35,
                              child: DropdownButtonFormField(
                                value: productsController.deliveryTypeId,
                                items: productsController.deliveryTypeList
                                    .map((data) {
                                  return DropdownMenuItem(
                                      value: data,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          data,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  productsController.deliveryTypeId = value;
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
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data =
                                  productsController.attributeAddList[index];
                              return Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(
                                      begin: Alignment(1.4153012037277222,
                                          0.15562866628170013),
                                      end: Alignment(-0.15562868118286133,
                                          0.044075123965740204),
                                      colors: [
                                        Color.fromRGBO(213, 210, 210, 0.749),
                                        Color.fromRGBO(223, 222, 222, 0.678)
                                      ]),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(File(data.image)),
                                  ),
                                  title: Text("Attribute Id: ${data.value}"),
                                  subtitle: Text("Quantity: ${data.quantity}"),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            productsController.attributeAddList
                                                .removeAt(index);
                                          },
                                          icon: Icon(Icons.remove_circle)),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount:
                                productsController.attributeAddList.length);
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      AddAttributeWidget(
                        attributesList: productsController.attributeLists,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AddButton(
                              onClick: () {
                                productsController.addAttributeToList();
                                // productsController.controllers
                                //     .add(TextEditingController());
                              },
                              productsController: productsController),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            return RemoveButton(
                                onTap: () {
                                  productsController.idOfAttribute.removeLast();
                                  productsController.controllers.removeLast();
                                },
                                visibility:
                                    productsController.controllers.length > 1
                                        ? true
                                        : false,
                                productsController: productsController);
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(7)),
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //         top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Variant",
                      //                     style:
                      //                         GoogleFonts.roboto(fontSize: 12),
                      //                   ),
                      //                   Container(
                      //                       height: 35, child: TextField()),
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(width: 20),
                      //             Expanded(
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Variant price",
                      //                     style:
                      //                         GoogleFonts.roboto(fontSize: 12),
                      //                   ),
                      //                   Container(
                      //                       height: 35, child: TextField()),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                      top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Return",
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),
                      NameAndDropDown(
                          productsController: productsController,
                          name: "Return Availability",
                          ontap: (p0) {
                            log(p0.toString());
                            productsController.returnAvailability = p0;
                          },
                          dropDownList: productsController.availabilityList),
                      SizedBox(height: 15),
                      FutureBuilder(
                          future: productsController.getAllReturn(),
                          builder: (constext, snap) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Return Reasons",
                                  style: GoogleFonts.roboto(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GetBuilder<ProductsController>(
                                    builder: (contexst) {
                                  return Container(
                                      child: MultiSelectDialogField(
                                    listType: MultiSelectListType.CHIP,
                                    items: contexst.returnReasons,
                                    title: Text('Select Options'),
                                    selectedItemsTextStyle:
                                        TextStyle(color: Colors.white),
                                    selectedColor:
                                        Color.fromARGB(255, 170, 86, 177),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 167, 54, 178)
                                            .withOpacity(0.1)),
                                    buttonText: Text('Select'),
                                    onConfirm: (selectedItems) {
                                      // Handle selected items
                                      contexst.getIdOfReturns(selectedItems);
                                      print('Selected Items: $selectedItems');
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
              padding: EdgeInsets.only(left: 4.w, top: 15, bottom: 15),
              child: Text("Product Image"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, bottom: 20),
              child: GetBuilder<ProductsController>(builder: (c) {
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
                      child: c.profileImage != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                Base64Decoder().convert(c.profileImage),
                                fit: BoxFit.cover,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                c.showPopup(context, "Add");
                              },
                              child: Center(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: Color.fromARGB(255, 125, 129, 234),
                                ),
                              ),
                            ),
                    ),
                    Visibility(
                      visible: c.profileImage == "" ? false : true,
                      child: InkWell(
                        onTap: () {
                          c.removeImage();
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
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Obx(() {
                            return ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: productsController.addLoading.value
                                    ? null
                                    : () async {
                                        productsController.addProducts(context);
                                      },
                                child: productsController.addLoading.value
                                    ? Row(
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          Text("  Processing",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white))
                                        ],
                                      )
                                    : Text(
                                        "Add",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ));
                          }))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddAttributeWidget extends StatelessWidget {
  const AddAttributeWidget({
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
          itemCount: productsController.controllers.value.length,
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
                                    productsController.attributeId = value;
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
                                              .valueAttributeController,
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
                                            .quantityAttributeController,
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

class NameAndDropDown extends StatelessWidget {
  NameAndDropDown(
      {super.key,
      required this.productsController,
      required this.name,
      required this.dropDownList,
      this.value,
      this.type,
      this.ontap});
  final String name;
  final type;
  final ProductsController productsController;
  final List dropDownList;
  Function(dynamic)? ontap;
  dynamic value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.roboto(fontSize: 12),
        ),
        Container(
            height: 35,
            child: DropdownButtonFormField(
              value: value,
              items: dropDownList.map((data) {
                return DropdownMenuItem(
                    value: data,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        data,
                        overflow: TextOverflow.visible,
                      ),
                    ));
              }).toList(),
              onChanged: ontap,
            )),
      ],
    );
  }
}

class DropdownAndTextfield extends StatelessWidget {
  DropdownAndTextfield(
      {super.key,
      required this.productsController,
      this.firstName,
      required this.textEditingController,
      this.secondName,
      required this.value,
      required this.droDownList,
      this.keyBoardType,
      required this.ontap});
  final firstName;
  final secondName;
  final value;
  final TextEditingController textEditingController;
  final ProductsController productsController;
  final Function(dynamic) ontap;
  TextInputType? keyBoardType;
  List droDownList;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstName,
                style: GoogleFonts.roboto(fontSize: 12),
              ),
              Container(
                  height: 35,
                  child: TextFormField(
                    keyboardType: keyBoardType ?? TextInputType.emailAddress,
                    controller: textEditingController,
                  )),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                secondName,
                style: GoogleFonts.roboto(fontSize: 12),
              ),
              Container(
                  height: 35,
                  child: DropdownButtonFormField(
                    value: value,
                    items: droDownList.map((data) {
                      return DropdownMenuItem(
                          value: data,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              data,
                              overflow: TextOverflow.visible,
                            ),
                          ));
                    }).toList(),
                    onChanged: ontap,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
