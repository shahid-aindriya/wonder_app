import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wonder_app/app/modules/shop_details/controllers/shop_details_controller.dart';

class AddOffers extends GetView<ShopDetailsController> {
  final shopId;
  AddOffers({super.key, this.shopId});

  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());
  final formKey = GlobalKey<FormState>();
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
                Form(
                  key: formKey,
                  child: Padding(
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
                          controller: shopDetailsController.titleController,
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
                                      color:
                                          Color.fromARGB(255, 199, 199, 179))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
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
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Obx(
                                    () => Radio<int>(
                                      fillColor: MaterialStateProperty.all(
                                          Color(0xff4956b2)),
                                      value: 1,
                                      groupValue: shopDetailsController
                                          .selectedDiscountValue.value,
                                      onChanged: (value) {
                                        shopDetailsController
                                            .selectedDiscountValue
                                            .value = value!;
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Discount percent',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.1725,
                                      color: Color(0xff4956b2),
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Obx(
                                    () => Radio<int>(
                                      fillColor: MaterialStateProperty.all(
                                          Color(0xff4956b2)),
                                      value: 2,
                                      groupValue: shopDetailsController
                                          .selectedDiscountValue.value,
                                      onChanged: (value) {
                                        shopDetailsController
                                            .selectedDiscountValue
                                            .value = value!;
                                      },
                                    ),
                                  ),
                                  Text('Discount Amount',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1725,
                                        color: Color(0xff4956b2),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 14.0, top: 5),
                        //   child: Row(
                        //     children: [
                        //       Obx(() {
                        //         return Text(
                        //           shopDetailsController
                        //                       .selectedDiscountValue.value ==
                        //                   1
                        //               ? 'Discount Pencentage'
                        //               : 'Discount Amount',
                        //           style: GoogleFonts.roboto(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w400,
                        //             height: 1.1725,
                        //             color: Color(0xff4956b2),
                        //           ),
                        //         );
                        //       }),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(() {
                          return TextFormField(
                            enabled: true,
                            controller:
                                shopDetailsController.discountController,
                            keyboardType: TextInputType.number,
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
                                hintText: shopDetailsController
                                            .selectedDiscountValue.value ==
                                        1
                                    ? "Enter dicount percentage"
                                    : "Enter dicount amount",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
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
                            validator: (value) {
                              if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!)) {
                                return 'please enter valid Number';
                              } else {
                                return null;
                              }
                            },
                          );
                        }),
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
                          controller:
                              shopDetailsController.descriptionController,
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
                                      color:
                                          Color.fromARGB(255, 199, 199, 179))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
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
                          return Visibility(
                            visible: scontext.offerImage == "" ? true : false,
                            child: Row(
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
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
                                    shopDetailsController.showPopup(
                                        context,
                                        (value) => shopDetailsController
                                            .pickimage(value));
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
                            ),
                          );
                        }),
                        GetBuilder<ShopDetailsController>(builder: (con) {
                          return Visibility(
                            visible: con.offerImage == "" ? false : true,
                            child: InkWell(
                              onTap: () {
                                con.showPopup(
                                    context,
                                    (value) =>
                                        shopDetailsController.pickimage(value));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 80.w,
                                  height: 200,
                                  child: (con.offerImage == "")
                                      ? Image.asset(
                                          "assets/images/invoice_image.png")
                                      : Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.memory(
                                              Base64Decoder()
                                                  .convert(con.offerImage),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Link ',
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
                          controller: shopDetailsController.linkController,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                              hintText: "type or paste link",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 199, 199, 179))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(16)),
                              fillColor: Color.fromARGB(153, 255, 255, 255),
                              focusColor: Color.fromARGB(255, 231, 231, 231)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Upload Video ',
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
                        Container(
                            height: 47,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Color.fromARGB(153, 255, 255, 255)),
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: () async {
                                      shopDetailsController.pickVideo(1);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xff4956b2),
                                    )))),
                        Obx(() {
                          final isVideoPlaying =
                              shopDetailsController.isVideoPlaying.value;
                          if (isVideoPlaying) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 89.w,
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: shopDetailsController
                                          .videoPlayerController!
                                          .value
                                          .aspectRatio,
                                      child: Chewie(
                                          controller: shopDetailsController
                                              .chewieController),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
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
                              if (formKey.currentState!.validate()) {
                                shopDetailsController.addOffers(
                                    link: shopDetailsController
                                        .linkController.text,
                                    descpition: shopDetailsController
                                        .descriptionController.text,
                                    discount: shopDetailsController
                                        .discountController.text,
                                    name: shopDetailsController
                                        .titleController.text,
                                    context: context,
                                    shopId: shopId);
                              }
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
