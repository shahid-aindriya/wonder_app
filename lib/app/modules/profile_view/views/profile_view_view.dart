import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/profile_view_controller.dart';

class ProfileViewView extends GetView<ProfileViewController> {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Profile',
            style: GoogleFonts.roboto(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
                height: 2,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/profile.png")),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 76.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 45,
                          height: 34,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color.fromARGB(255, 144, 149, 255),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "Allen Solly",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 22,
                      height: 2.3,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),

            // Figma Flutter Generator Rectangle17Widget - RECTANGLE
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w, bottom: 8),
                    child: Text("Store Name",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(11, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.4153012037277222, 0.15562866628170013),
                          end: Alignment(
                              0.15562868118286133, 0.044075123965740204),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.6800000071525574),
                            Color.fromRGBO(255, 226, 228, 245),
                          ]),
                    ),
                    child: ListTile(
                      title: Text("Allen Solly",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/edit.png")),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w, bottom: 8),
                    child: Text("Seller Name",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(11, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.4153012037277222, 0.15562866628170013),
                          end: Alignment(
                              0.15562868118286133, 0.044075123965740204),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.6800000071525574),
                            Color.fromRGBO(255, 226, 228, 245),
                          ]),
                    ),
                    child: ListTile(
                      title: Text("Abraham Ahmed",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/edit.png")),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w, bottom: 8),
                    child: Text("Mobile",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(11, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.4153012037277222, 0.15562866628170013),
                          end: Alignment(
                              0.15562868118286133, 0.044075123965740204),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.6800000071525574),
                            Color.fromRGBO(255, 226, 228, 245),
                          ]),
                    ),
                    child: ListTile(
                      title: Text("+91 99846 54656",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/edit.png")),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w, bottom: 8),
                    child: Text("E-mail",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(11, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.4153012037277222, 0.15562866628170013),
                          end: Alignment(
                              0.15562868118286133, 0.044075123965740204),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.6800000071525574),
                            Color.fromRGBO(255, 226, 228, 245),
                          ]),
                    ),
                    child: ListTile(
                      title: Text("allensollykakkanad@gmail.com",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/edit.png")),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.4.w, bottom: 8),
                    child: Text("Location",
                        style: GoogleFonts.roboto(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(11, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.4153012037277222, 0.15562866628170013),
                          end: Alignment(
                              0.15562868118286133, 0.044075123965740204),
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.6800000071525574),
                            Color.fromRGBO(255, 226, 228, 245),
                          ]),
                    ),
                    child: ListTile(
                      title: Text(
                          "Edachira Jn, Kakkanad, 683 464, Kerala, Indi...",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.my_location)),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 124,
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
                          child: Center(
                            child: Text(
                              'Save',
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
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
