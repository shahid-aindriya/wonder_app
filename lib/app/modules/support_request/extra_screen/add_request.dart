import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wonder_app/app/modules/support_request/controllers/support_request_controller.dart';

class AddRequest extends GetView<SupportRequestController> {
  AddRequest({super.key});
  final SupportRequestController supportRequestController =
      Get.put(SupportRequestController());
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
          ],
        ),
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
            'Add Request',
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
                padding: EdgeInsets.only(top: 20, left: 5.w, right: 5.w),
                child: Column(
                  children: [
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
                    FutureBuilder(
                        future: supportRequestController.getListOfShops(),
                        builder: (cosntext, snapshot) {
                          return Obx(() {
                            return Container(
                                height: 55,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(
                                                  255, 199, 199, 179))),
                                      filled: true,
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color.fromARGB(255, 255, 255, 255)),
                                          borderRadius: BorderRadius.circular(16)),
                                      fillColor: Color.fromARGB(153, 255, 255, 255),
                                      focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  value: supportRequestController.selectShopId,
                                  onChanged: (value) async {
                                    supportRequestController.changeShop(
                                        value: value);
                                  },
                                  items: supportRequestController
                                      .shopLists.value
                                      .map((data) {
                                    return DropdownMenuItem(
                                        value: data.id.toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Text(
                                            data.name,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ));
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please select value";
                                    }
                                    return null;
                                  },
                                ));
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Row(
                        children: [
                          Text(
                            'Request Title',
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
                      controller: supportRequestController.titleController,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.1725,
                            color: Color.fromARGB(93, 0, 0, 0),
                          ),
                          hintText: "Enter the title of the request",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 18),
                          enabled: true,
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
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
                        if (value!.length < 3) {
                          return 'please enter valid title';
                        } else {
                          return null;
                        }
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
                            'Request Description',
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
                      maxLines: 10,
                      controller:
                          supportRequestController.descriptionController,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.1725,
                            color: Color.fromARGB(93, 0, 0, 0),
                          ),
                          hintText: "Enter the description of the request",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 18),
                          enabled: true,
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  width: 0,
                                  color: Color.fromARGB(255, 199, 199, 179))),
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
                          return 'please enter description';
                        } else {
                          return null;
                        }
                      },
                    ),
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
                      child: Obx(() {
                        return ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed:
                              supportRequestController.isAddRequest.value ==
                                      true
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        supportRequestController
                                            .addRequest(context);
                                      }
                                    },
                          child: supportRequestController.isAddRequest.value ==
                                  true
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  '   Submit   ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2110513051,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                        );
                      })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
