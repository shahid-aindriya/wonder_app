import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/chat/extra/broadcast_list.dart';
import 'package:wonder_app/app/modules/chat/extra/chat_box.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
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
            'Chat List',
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
              padding: const EdgeInsets.all(8.0),
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
                    hintText: "Search Chat",
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
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Recent Chats",
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
                          EdgeInsets.only(left: 4.w, right: 4.w, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          index != 0
                              ? Get.to(ChatBox())
                              : Get.to(BroadCastList());
                        },
                        child: Container(
                          width: 100.w,
                          decoration: index == 0
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.05000000074505806),
                                        offset: Offset(0, 2),
                                        blurRadius: 6)
                                  ],
                                  color: Color.fromRGBO(199, 201, 255, 1),
                                )
                              : BoxDecoration(
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
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person),
                              ],
                            ),
                            title: Text(
                                index == 0 ? "Broadcast List" : "Rakesh Sharma",
                                style: GoogleFonts.roboto(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            subtitle: Text(
                                index == 0
                                    ? "Black T-shirt plane round neck..."
                                    : "what will be the offer price?",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                )),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "10:15 pm",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
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
