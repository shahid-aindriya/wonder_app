import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/connections_controller.dart';

class ConnectionsView extends GetView<ConnectionsController> {
  const ConnectionsView({Key? key}) : super(key: key);
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
            'Connections',
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
              padding: EdgeInsets.only(top: 10.0, right: 4.w, left: 4.w),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      enabled: true,

                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.1725,
                            color: Color.fromARGB(93, 0, 0, 0),
                          ),
                          hintText: "Search Number",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 18),
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
                        if (!RegExp(r"^\d{10}$").hasMatch(value!) ||
                            value.length < 3) {
                          return 'please enter valid number';
                        } else {
                          return null;
                        }
                      },
                      // onTap: () {
                      //   Get.to(SearchUser(),
                      //       arguments: TextData(
                      //           searchUserController, selectUserId));
                      // },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 114, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(71, 118, 230, .7),
                          Color.fromRGBO(141, 84, 233, .9)
                        ], // Replace these with your desired colors
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "+ Add New",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )),
                    // Other content within the container (e.g., child widgets) can be added here.
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 20, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "All Connections",
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: 10, left: 4.w, right: 4.w),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                    begin: Alignment(1.4153012037277222,
                                        0.15562866628170013),
                                    end: Alignment(-0.15562868118286133,
                                        0.044075123965740204),
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 0.75),
                                      Color.fromRGBO(
                                          255, 255, 255, 0.6800000071525574)
                                    ]),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person),
                                    ],
                                  ),
                                  title: Text("Rakesh Sharma",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text("+91 549765498",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          index.isEven
                              ? Container(
                                  height: 70,
                                  width: 114,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment(1.4153012037277222,
                                            0.15562866628170013),
                                        end: Alignment(-0.15562868118286133,
                                            0.044075123965740204),
                                        colors: [
                                          Color.fromRGBO(255, 255, 255, 0.75),
                                          Color.fromRGBO(
                                              255, 255, 255, 0.6800000071525574)
                                        ]),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.mail_rounded,
                                        color: Color.fromARGB(255, 73, 86, 178),
                                      ),
                                      Text(
                                        "Invite",
                                        style: GoogleFonts.roboto(
                                            color: Color.fromARGB(
                                                255, 73, 86, 178),
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 70,
                                  width: 114,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 73, 86, 178)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Message",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
