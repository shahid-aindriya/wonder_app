import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/vendors_added/extra/vendor_details.dart';

import '../controllers/vendors_added_controller.dart';

class VendorsAddedView extends GetView<VendorsAddedController> {
  const VendorsAddedView({Key? key}) : super(key: key);
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
            title: Text(
              'Vendors Added',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
                child: Column(
                  children: [
                    TextFormField(
                      enabled: true,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color.fromRGBO(0, 0, 0, .6)),
                          hintText: "Search Vendors Here...",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 20),
                          enabled: true,
                          suffixIcon: InkWell(
                              onTap: () {
                                // invoiceController.currentPage.value = 1;
                                // invoiceController.search(
                                //     invoiceController.searchInvoiceController.text);
                              },
                              child: Image.asset("assets/images/search.png")),
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
                          fillColor: Color.fromARGB(92, 255, 255, 255),
                          focusColor: Color.fromARGB(255, 231, 231, 231)),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (contexta, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 15, right: 5.w, left: 5.w),
                        child: InkWell(
                          onTap: () {
                            Get.to(VendorDetails());
                          },
                          child: Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                  begin: Alignment(
                                      1.4153012037277222, 0.15562866628170013),
                                  end: Alignment(-0.15562868118286133,
                                      0.044075123965740204),
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 0.75),
                                    Color.fromRGBO(
                                        255, 255, 255, 0.6800000071525574)
                                  ]),
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person),
                                ],
                              ),
                              title: Text("Dessi Cuppa Kakkanad",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Added on",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text("10 Jan, 2023",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restaurant,
                                    color: Color(0xff4956b2),
                                  ),
                                  Text(
                                    "Restaurant",
                                    style: GoogleFonts.roboto(
                                        color: Color(0xff4956b2),
                                        // data.entryType == "Debit"
                                        //     ?
                                        //      Color.fromARGB(255, 243, 106, 106)
                                        //     :

                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // Text("data.createdAt.toString()",
                                  //     style: GoogleFonts.roboto(
                                  //         fontSize: 10, fontWeight: FontWeight.w300))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
