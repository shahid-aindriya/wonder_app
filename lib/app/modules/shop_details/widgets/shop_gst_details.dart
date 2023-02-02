import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopGstDetails extends StatelessWidget {
  ShopGstDetails({super.key});
  final TextEditingController gstController =
      TextEditingController(text: "3457634657efr");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.png"),
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
            'GST Details',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'GST Number',
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
                    controller: gstController,
                    enabled: true,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: [
                        Text(
                          'License Copy',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    child: Container(
                        width: 100.w,
                        child: Image.asset("assets/images/invoice_image.png")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
