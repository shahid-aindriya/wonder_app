import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';

import '../../add_invoice/views/add_invoice_view.dart';
import '../../add_invoice/widgets/searcg.dart';
import '../controllers/request_coins_controller.dart';

class RequestCoinsView extends GetView<RequestCoinsController> {
  RequestCoinsView({Key? key}) : super(key: key);

  final RequestCoinsController requestCoinsController =
      Get.put(RequestCoinsController());
  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());

  final TextEditingController searchUserController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController selectUserId = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            'Request Coins',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'Select User',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.1725,
                            color: Color(0xff4956b2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: true,
                    controller: searchUserController,
                    keyboardType: TextInputType.none,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintText: "Search User",
                        suffixIcon: Icon(Icons.search),
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 18),
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
                    onTap: () {
                      Get.to(SearchUser(),
                          arguments:
                              TextData(searchUserController, selectUserId));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'Select Shop',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.1725,
                            color: Color(0xff4956b2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return DropdownButtonFormField(
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 18),
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
                      value: requestCoinsController.selectShopId,
                      onChanged: (value) {
                        requestCoinsController.changeShop(
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
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'Amount',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.1725,
                            color: Color(0xff4956b2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: true,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
                        hintText: "Enter amount",
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.1725,
                          color: Color.fromARGB(93, 0, 0, 0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 18),
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
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value!) ||
                          value.length < 3) {
                        return 'please enter valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 50,
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
                        fixedSize: MaterialStateProperty.all(Size(150, 50)),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      requestCoinsController.requestCoins(
                          context: context,
                          userId: int.tryParse(selectUserId.text),
                          amount: int.tryParse(amountController.text));
                    },
                    child: Text(
                      'Request Coins',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.2110513051,
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
