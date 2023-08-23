import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wonder_app/app/data/urls.dart';

import '../../../data/colors.dart';
import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../invoice/views/invoice_view.dart';
import '../../invoice/widgets/drawer_tab.dart';
import '../../invoice/widgets/notification_icon.dart';
import '../../notifications/views/notifications_view.dart';
import '../controllers/products_controller.dart';
import '../extra/add_products_view.dart';
import '../extra/edit_products_details.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({Key? key}) : super(key: key);
  final AddInvoiceController addInvoiceController = Get.find();

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
        drawer: DrawerTab(addInvoiceController: addInvoiceController),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(builder: (contezxt) {
            return InkWell(
              onTap: () async {
                await invoiceController.getUserData();
                Scaffold.of(contezxt).openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: textGradientBlue,
                  ),
                ),
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FutureBuilder(
                  future: addInvoiceController.getListOfShops(),
                  builder: (contextsd, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 60.w,
                        height: 50,
                        child: Shimmer(
                          color: Color.fromARGB(255, 185, 84, 84),
                          child: ListTile(
                            dense: true,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 220, 216, 216),
                                  radius: 20,
                                ),
                              ],
                            ),
                            title: Container(
                              height: 20,
                              color: Color.fromARGB(255, 220, 216, 216),
                            ),
                            subtitle: Container(
                              height: 16,
                              margin: EdgeInsets.only(top: 8),
                              color: Color.fromARGB(255, 220, 216, 216),
                            ),
                          ),
                          direction: ShimmerDirection.fromRTLB(),
                        ),
                      );
                    }
                    return Obx(() {
                      return Container(
                          width: 60.w,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            isDense: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Select Shop",
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            value: invoiceController.selectShopId,
                            onChanged: (value) async {
                              invoiceController.invoiceListsFilter.value
                                  .clear();
                              invoiceController.walletTransactionLists.clear();
                              invoiceController.invoiceLists.value.clear();
                              invoiceController.walletCurrentpage.value = 1;
                              invoiceController.invoiceCurrentpage.value = 1;
                              invoiceController.shopWalletAmount.value = "0";
                              invoiceController.dueList.clear();
                              invoiceController.walletAmount.value = '';
                              invoiceController.filterPage.value = 1;
                              invoiceController.dueTotalCount.value = 1;
                              invoiceController.dueCurrentCount.value = 1;
                              invoiceController.debitListValue.value = "All";
                              invoiceController.changeShop(
                                value: value,
                              );
                              await invoiceController.checkVerifiedVendor();
                              await invoiceController.onDropDownChanged(value);
                              await invoiceController
                                  .ondropDownChangedInvoice(value);
                              await invoiceController.getDueData();
                              await productsController.getListOfPrdoucts(value);
                            },
                            items: addInvoiceController.shopLists.value
                                .map((data) {
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
                          ));
                    });
                  }),
            ),
            Container(
              decoration: BoxDecoration(),
              child: InkWell(
                onTap: () {
                  Get.to(NotificationsView(
                    invoiceController: invoiceController,
                  ));
                },
                child: Center(
                  child: BellWidget(),
                ),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 20, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Products",
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Row(
                children: [
                  Text("Category",
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Container(
                      height: 40,
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, .6)),
                            hintText: "Select",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            focusColor: Color.fromARGB(255, 255, 255, 255)),
                        value: productsController.selectedValue,
                        onChanged: (value) async {
                          productsController.selectedValue = value;
                        },
                        items: productsController.categoryList.map((data) {
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
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Sort by",
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Container(
                      height: 40,
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, .6)),
                            hintText: "Select",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            focusColor: Color.fromARGB(255, 255, 255, 255)),
                        value: productsController.sortValue,
                        onChanged: (value) async {
                          productsController.sortValue = value;
                        },
                        items: productsController.sortList.map((data) {
                          return DropdownMenuItem(
                              value: data,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  data,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return productsController.productsLists.isEmpty
                    ? Lottie.asset("assets/images/13659-no-data.json")
                    : ListView.builder(
                        itemCount: productsController.productsLists.length,
                        itemBuilder: (context, index) {
                          final data = productsController.productsLists[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 4.w, right: 4.w),
                            child: InkWell(
                              onTap: () {
                                Get.to(EditProductDetails(
                                  id: data.id,
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 20.w,
                                            height: 80,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                "$baseUrlForImage${data.featuredImage}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              productsController
                                                  .removeItem(data.id);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color.fromARGB(
                                                      255, 81, 90, 197)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7.0,
                                                    left: 11,
                                                    right: 11,
                                                    top: 6),
                                                child: Text(
                                                  "Remove item",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Product id: 644565465433",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14,
                                                  color: Colors.blueGrey),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text("Selling Price",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blueGrey)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "₹${data.price}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        81,
                                                                        90,
                                                                        197)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text("Quantity",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blueGrey)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data.quantity,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        81,
                                                                        90,
                                                                        197)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text("Status",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blueGrey)),
                                                      Container(
                                                        height: 25,
                                                        child: Obx(() {
                                                          return Switch
                                                              .adaptive(
                                                            activeColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    81,
                                                                    90,
                                                                    197),
                                                            value: productsController
                                                                .productsLists[
                                                                    index]
                                                                .active,
                                                            onChanged: (value) {
                                                              productsController
                                                                  .switchChange(
                                                                      value,
                                                                      data.id);
                                                            },
                                                          );
                                                        }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
              }),
            )
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 57, 55, 166),
            onPressed: () {
              Get.to(AddProductsView());
            },
            child: Icon(
              Icons.add,
              size: 30,
            )),
      ),
    );
  }
}
