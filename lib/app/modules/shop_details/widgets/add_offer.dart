import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/shop_details/controllers/shop_details_controller.dart';

class AddOffers extends GetView<ShopDetailsController> {
  final shopId;
  AddOffers({super.key, this.shopId});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());
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
                'Add Offers',
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
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Title',
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
                        controller: titleController,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter title",
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
                          if (value!.isEmpty) {
                            return 'please enter valid data';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Discount',
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
                        controller: discountController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter dicount amount",
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
                          if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!)) {
                            return 'please enter valid Number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Description',
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
                        controller: descriptionController,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter description",
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
                          if (value!.isEmpty) {
                            return 'please enter valid description';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Offer Image',
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
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      height: 1.1725,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    hintText:
                                        shopDetailsController.offerImage == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 18),
                                    enabled: true,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            topLeft: Radius.circular(16)),
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
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            topLeft: Radius.circular(16))),
                                    fillColor:
                                        Color.fromARGB(153, 255, 255, 255),
                                    focusColor:
                                        Color.fromARGB(255, 231, 231, 231)),
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
                              onTap: () {
                                shopDetailsController.pickimage();
                              },
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
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(100, 50)),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              shopDetailsController.addOffers(
                                  descpition: descriptionController.text,
                                  discount: discountController.text,
                                  name: titleController.text,
                                  context: context,
                                  shopId: shopId);
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
                          )),
                    ],
                  ),
                ],
              ),
            )));
  }
}
