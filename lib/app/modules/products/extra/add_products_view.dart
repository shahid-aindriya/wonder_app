import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/products_controller.dart';

class AddProductsView extends StatelessWidget {
  AddProductsView({super.key});
  final ProductsController productsController = Get.put(ProductsController());
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
                      Container(height: 35, child: TextField()),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Short Description",
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                      Container(height: 35, child: TextField()),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownAndTextfield(
                          droDownList: productsController.unitList,
                          firstName: "Selling Price",
                          secondName: "Unit",
                          productsController: productsController),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownAndTextfield(
                          droDownList: productsController.unitList,
                          firstName: "Tax",
                          secondName: "Tax Type",
                          productsController: productsController),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownAndTextfield(
                          droDownList: productsController.unitList,
                          firstName: "Discount",
                          secondName: "Discount Type",
                          productsController: productsController),
                      SizedBox(
                        height: 20,
                      ),
                      NameAndDropDown(
                        productsController: productsController,
                        dropDownList: productsController.unitList,
                        name: "Category",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NameAndDropDown(
                        productsController: productsController,
                        dropDownList: productsController.unitList,
                        name: "Sub-Category",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NameAndDropDown(
                        productsController: productsController,
                        dropDownList: productsController.unitList,
                        name: "Attribute",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NameAndDropDown(
                        productsController: productsController,
                        dropDownList: productsController.unitList,
                        name: "Color",
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 4.w, left: 4.w, bottom: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Variant",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35, child: TextField()),
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
                                          "Variant price",
                                          style:
                                              GoogleFonts.roboto(fontSize: 12),
                                        ),
                                        Container(
                                            height: 35, child: TextField()),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
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
                    children: [],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NameAndDropDown extends StatelessWidget {
  const NameAndDropDown({
    super.key,
    required this.productsController,
    required this.name,
    required this.dropDownList,
  });
  final String name;
  final ProductsController productsController;
  final List dropDownList;

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
              onChanged: (value) {},
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
      this.secondName,
      required this.droDownList});
  final firstName;
  final secondName;
  final ProductsController productsController;
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
              Container(height: 35, child: TextField()),
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
                    onChanged: (value) {},
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
