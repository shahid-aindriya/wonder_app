import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/data/colors.dart';
import 'package:wonder_app/app/modules/add_invoice/views/add_invoice_view.dart';
import 'package:wonder_app/app/modules/invoice/widgets/search_invoice.dart';
import 'package:wonder_app/app/modules/login/views/login_view.dart';

import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../my_shops/views/my_shops_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../profile_view/views/profile_view_view.dart';
import '../../terms_conditions/views/terms_conditions_view.dart';
import '../controllers/invoice_controller.dart';
import '../widgets/invoices_tab.dart';
import '../widgets/notification_icon.dart';
import '../widgets/wallet_tab.dart';

class InvoiceView extends GetView<InvoiceController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InvoiceController invoiceController = Get.put(InvoiceController());
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());
          FirebaseMessaging messaging = FirebaseMessaging.instance;
      
  void pushFCMtoken() async {
    String? token = await messaging.getToken();

    print("token:$token");
    print("hello");
    await sendDeviceToken(token!);
  }

  Future<void> sendDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    print("dzvjhjxhbv$userId");
   
    var response = await post(
      Uri.parse('http://64.227.156.53:8000/vendor-update-device-token/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
      body: jsonEncode(
          <String, dynamic>{"user_id": userId, "device_token": token}),
    );
    print('status${response.statusCode}');

    if (response.statusCode == 201) {
      print("got token");
      print(response.statusCode);
    } else {
      throw Exception("failed to send token");
    }
  }

  @override
  Widget build(BuildContext context) {
    pushFCMtoken();
    invoiceController.notifications();
    addInvoiceController.getListOfShops();
    // invoiceController.getInvoiceLists();
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wonder_app_background.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Color.fromARGB(
              255,
              239,
              240,
              246,
            ),
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 124,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset("assets/images/profile.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Allen Solly",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(255, 63, 69, 189),
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Kakkanad",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w300)),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(ProfileViewView());
                    },
                    leading: Image.asset(
                      "assets/images/User.png",
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "View Profile",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(177, 0, 0, 0),
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(ProfileViewView());
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Divider(color: Colors.white, thickness: 2),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(MyShopsView());
                      // Get.to(BankDetailsView());
                    },
                    leading: Image.asset(
                      "assets/images/Storefront.png",
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "My Shops",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(177, 0, 0, 0),
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(MyShopsView());
                          // Get.to(BankDetailsView());
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 6.0),
                  //   child: Divider(color: Colors.white, thickness: 2),
                  // ),
                  // ListTile(
                  //   leading: Image.asset(
                  //     "assets/images/SuitcaseSimple.png",
                  //     fit: BoxFit.contain,
                  //   ),
                  //   title: Text(
                  //     "GST Details",
                  //     style: GoogleFonts.roboto(
                  //         color: Color.fromARGB(177, 0, 0, 0),
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  //   trailing: IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.arrow_forward_ios_outlined)),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 6.0),
                  //   child: Divider(color: Colors.white, thickness: 2),
                  // ),
                  // ListTile(
                  //   leading: Image.asset(
                  //     "assets/images/Bank.png",
                  //     fit: BoxFit.contain,
                  //   ),
                  //   title: Text(
                  //     "Bank Details",
                  //     style: GoogleFonts.roboto(
                  //         color: Color.fromARGB(177, 0, 0, 0),
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  //   trailing: IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(Icons.arrow_forward_ios_outlined)),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Divider(color: Colors.white, thickness: 2),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(TermsConditionsView());
                    },
                    leading: Image.asset(
                      "assets/images/ClipboardText.png",
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Terms & Conditions",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(177, 0, 0, 0),
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(TermsConditionsView());
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Divider(color: Colors.white, thickness: 2),
                  ),
                  ListTile(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Get.offAll(LoginView());
                    },
                    leading: Image.asset(
                      "assets/images/SignOut.png",
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(177, 0, 0, 0),
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          Get.offAll(LoginView());
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )
            ]),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Builder(builder: (contezxt) {
              return InkWell(
                onTap: () {
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
                child: Obx(() {
                  return Container(
                      width: 60.w,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        isDense: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
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
                                    color: Color.fromARGB(255, 199, 199, 179))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(16)),
                            fillColor: Color.fromARGB(153, 255, 255, 255),
                            focusColor: Color.fromARGB(255, 231, 231, 231)),
                        value: invoiceController.selectShopId,
                        onChanged: (value) {
                          invoiceController.onDropDownChanged(value);
                          invoiceController.changeShop(
                            value: value,
                          );
                        },
                        items: addInvoiceController.shopLists.value.map((data) {
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
              Container(
                height: 57,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0.2),
                      blurRadius: 10,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 243, 229, 223),
                      Color.fromARGB(255, 229, 230, 244)
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: TabBar(
                  unselectedLabelColor: Color.fromARGB(255, 151, 151, 155),
                  labelStyle: GoogleFonts.roboto(
                      color: textGradientBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  labelColor: textGradientBlue,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color.fromARGB(255, 247, 240, 240),
                    gradient: LinearGradient(
                        begin:
                            Alignment(1.0411021709442139, 0.002192780375480652),
                        end: Alignment(
                            -0.002192780375480652, 0.01846526376903057),
                        colors: [
                          Color.fromARGB(255, 247, 240, 240),
                          Color.fromARGB(255, 247, 240, 240)
                        ]),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                ImageIcon(AssetImage(
                                    "assets/images/invoice-icon.png")),
                                Text(
                                  "Invoices",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                ImageIcon(
                                    AssetImage("assets/images/Wallet.png")),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2.0, left: 2),
                                  child: Text(
                                    "Wallet",
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50.w,
                                child: TextFormField(
                                  enabled: true,
                                  keyboardType: TextInputType.none,
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                  decoration: InputDecoration(
                                      hintStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, .6)),
                                      hintText: "Search invoice",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 20),
                                      enabled: true,
                                      suffixIcon: InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                              "assets/images/search.png")),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                      fillColor: Color.fromARGB(92, 255, 255, 255),
                                      focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  onTap: () {
                                    Get.to(SearchInvoice(
                                      invoiceController: invoiceController,
                                    ));
                                  },
                                ),
                              ),
                              Obx(() {
                                return Container(
                                  width: 40.w,
                                  child: DropdownButtonFormField(
                                    isDense: true,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                        hintStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Color.fromRGBO(0, 0, 0, .6)),
                                        hintText: "Select",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0.0, horizontal: 10),
                                        enabled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        fillColor:
                                            Color.fromARGB(92, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                    value:
                                        invoiceController.filterListValue.value,
                                    onChanged: (value) {
                                      invoiceController.filterListValue.value =
                                          value.toString();
                                      invoiceController
                                          .onFilterListChange(value);
                                    },
                                    items: invoiceController.filterList
                                        .map((data) {
                                      return DropdownMenuItem(
                                          value: data,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Text(
                                              data,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ));
                                    }).toList(),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Expanded(
                            child: InvoiceTab(
                                invoiceController: invoiceController)),
                      ],
                    ),
                    WalletTab(invoiceController: invoiceController),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 57, 55, 166),
              onPressed: () {
                Get.to(AddInvoiceView());
              },
              child: Icon(
                Icons.add,
                size: 30,
              )),
        ),
      ),
    );
  }
}
