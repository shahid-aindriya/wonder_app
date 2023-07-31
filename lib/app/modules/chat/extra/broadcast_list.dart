import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BroadCastList extends StatelessWidget {
  const BroadCastList({super.key});

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
              'Broadcast List',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // final item = chatController.messageLists.reversed
                    //     .toList()[index];
                    // final String dateString = item.createdAt.toString();
                    // final DateTime date = DateTime.parse(dateString);
                    // bool isSameDate = false;

                    // if (index < chatController.messageLists.length - 1) {
                    //   final String nextDateString = chatController
                    //       .messageLists[index + 1].createdAt
                    //       .toString();
                    //   final DateTime nextDate =
                    //       DateTime.parse(nextDateString);
                    //   isSameDate = date.year == nextDate.year &&
                    //       date.month == nextDate.month &&
                    //       date.day == nextDate.day;
                    // }

                    // if (!isSameDate) {
                    //   return
                    //   Column(
                    //     children: [

                    //       BubbleNormal(
                    //         sent: true,
                    //         delivered: true,
                    //         text: item.message.toString(),
                    //         isSender: item.isReplay == null ? true : false,
                    //         color: item.isReplay == null
                    //             ? greenGradient1
                    //             : whiteText,
                    //         tail: true,
                    //         textStyle: TextStyle(
                    //           fontSize: 20,
                    //           color:
                    //               item.isReplay == null ? whiteText : black,
                    //         ),
                    //       ),
                    //     ],
                    //   );
                    // } else {
                    //   return
                    return Column(
                      children: [
                        DateChip(date: DateTime.now()),
                        Row(
                          mainAxisAlignment: index.isEven
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 70.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 71, 118, 230),
                                    Color.fromARGB(255, 142, 84, 233)
                                  ])),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 118,
                                      width: 102,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/image 87.png",
                                              ),
                                              fit: BoxFit.contain),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Black T-Shirt rounded neck plane",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Puma",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                '₹869',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 231, 65, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 18,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1),
                                              ),
                                              Text(
                                                '  1200',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily: 'Roboto',
                                                    fontSize: 18,
                                                    letterSpacing:
                                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        BubbleNormal(
                          sent: true,
                          delivered: true,
                          text: "hai",
                          isSender: index.isEven ? true : false,
                          color: index.isEven
                              ? Color.fromARGB(255, 202, 208, 247)
                              : Colors.white,
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 242, 232, 255)),
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 42,
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
                            hintText: "Type here..",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 18),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 81, 90, 197))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 81, 90, 197)),
                                borderRadius: BorderRadius.circular(16)),
                            fillColor: Color.fromARGB(255, 217, 209, 235),
                            focusColor: Color.fromARGB(255, 217, 209, 235)),
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
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 81, 90, 197),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
