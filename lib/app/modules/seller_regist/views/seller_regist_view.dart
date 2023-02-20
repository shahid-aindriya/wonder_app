import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/password_generation/views/password_generation_view.dart';

import '../controllers/seller_regist_controller.dart';

class SellerRegistView extends GetView<SellerRegistController> {
  @override
  final SellerRegistController controller = Get.put(SellerRegistController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameEditingController = TextEditingController();
    final TextEditingController phoneNumberEditingController =
        TextEditingController();
    final TextEditingController adhaarNumberEditingController =
        TextEditingController();
    final TextEditingController panNumberEditingController =
        TextEditingController();
    final TextEditingController emailEditingController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to WonderApp',
                      style: GoogleFonts.jost(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.445,
                        color: Color(0xff4956b2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'Register your store at WonderApp & get unlimited benefits on the go!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.445,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                height: 112,
                child: Image.asset(
                  "assets/images/handshake.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Seller Name',
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
                            controller: nameEditingController,
                            enabled: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter your name...",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
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
                              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Seller Email',
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
                            controller: emailEditingController,
                            enabled: true,
                            keyboardType: TextInputType.emailAddress,
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
                                hintText: "Enter your email",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                errorBorder: OutlineInputBorder(
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
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Phone Number',
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
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: phoneNumberEditingController,
                            enabled: true,
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
                                hintText: "Enter Phone Number",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (!RegExp(r"^\d{10}$").hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Adhaar Number',
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
                            maxLength: 12,
                            controller: adhaarNumberEditingController,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {}, icon: Icon(Icons.my_location)),
                                // suffix: Container(
                                //   height: 23,
                                //   child: Image.asset(
                                //     "assets/images/store_location.png",
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Enter 12 digit number",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (!RegExp(r"^\d{12}$").hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid adhaar ';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          // Text(
                          //   'Upload Store Photo',
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //     height: 1.1725,
                          //     color: Color(0xff4956b2),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   width: 146,
                          //   height: 139,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(13),
                          //       color: Colors.white
                          //       // gradient: LinearGradient(
                          //       //   begin: Alignment(-0.696, -0),
                          //       //   end: Alignment(1.161, 1.413),
                          //       //   colors: <Color>[Color(0x97ffffff), Color(0x7bffffff)],
                          //       //   stops: <double>[0, 1],
                          //       // ),
                          //       ),
                          //   child: Center(
                          //       child: Icon(Icons.add,
                          //           size: 41,
                          //           color: Color.fromARGB(255, 73, 86, 178))),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'Adhar Card Photo',
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
                          GetBuilder<SellerRegistController>(
                              builder: (contextj) {
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
                                          color: Color.fromARGB(167, 0, 0, 0),
                                        ),
                                        hintText: controller.adhaarimg == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 199, 199, 179))),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.pickimage();
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
                          SizedBox(
                            height: 29,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'PAN Number',
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
                            controller: panNumberEditingController,
                            enabled: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {}, icon: Icon(Icons.my_location)),
                                // suffix: Container(
                                //   height: 23,
                                //   child: Image.asset(
                                //     "assets/images/store_location.png",
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.1725,
                                  color: Color.fromARGB(93, 0, 0, 0),
                                ),
                                hintText: "Eg. ABCDE1234E",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        width: 0,
                                        color: Color.fromARGB(
                                            255, 199, 199, 179))),
                                errorBorder: OutlineInputBorder(
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
                              if (!RegExp(r"^[A-Z]{5}\d{4}[A-Z]{1}$")
                                      .hasMatch(value!) ||
                                  value.length < 3) {
                                return 'please enter valid Pan number and in Capital letters';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Row(
                              children: [
                                Text(
                                  'PAN Card Photo',
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
                          GetBuilder<SellerRegistController>(
                              builder: (context) {
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
                                          color: Color.fromARGB(167, 0, 0, 0),
                                        ),
                                        hintText: controller.panimg == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 199, 199, 179))),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await controller.pickimage2();
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
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 52,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 124,
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Get.to(PasswordGenerationView(
                              adhaarNumber: adhaarNumberEditingController.text,
                              adhaarimag: controller.adhaarimg,
                              name: nameEditingController.text,
                              panImag: controller.panimg,
                              panNumber: panNumberEditingController.text,
                              phoneNmber: phoneNumberEditingController.text,
                              email: emailEditingController.text,
                            ));
                          }
                        },
                        child: Text(
                          'Next',
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
              SizedBox(
                height: 52,
              ),
            ],
          )),
    );
  }
}
