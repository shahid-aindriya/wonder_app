import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/support_request_controller.dart';
import '../extra_screen/add_request.dart';

class SupportRequestView extends GetView<SupportRequestController> {
  SupportRequestView({Key? key}) : super(key: key);
  final SupportRequestController supportRequestController =
      Get.put(SupportRequestController());
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
            'Support Request',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w, top: 10),
            //   child: Container(
            //     height: 30,
            //     child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: supportRequestController.requesstList.length,
            //       itemBuilder: (context, index) {
            //         final data = supportRequestController.requesstList[index];
            //         return InkWell(
            //           onTap: () {
            //             supportRequestController.changeColor(index);
            //           },
            //           child: Obx(() {
            //             return DottedBorder(
            //               borderType: BorderType.RRect,
            //               radius: Radius.circular(10),
            //               color: supportRequestController.selectedIndex.value ==
            //                       index
            //                   ? Color(0xff4956b2)
            //                   : Color.fromARGB(255, 175, 170, 170),
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     top: 5.0, bottom: 5, left: 15, right: 15),
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(20)),
            //                   child: Text(
            //                     data,
            //                     style: GoogleFonts.roboto(
            //                         color: supportRequestController
            //                                     .selectedIndex.value ==
            //                                 index
            //                             ? Color(0xff4956b2)
            //                             : Color.fromARGB(255, 117, 113, 113)),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }),
            //         );
            //       },
            //       separatorBuilder: (context, index) {
            //         return SizedBox(
            //           width: 10,
            //         );
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: supportRequestController.getRequests(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        controller:
                            supportRequestController.requestScrollController,
                        itemCount: supportRequestController.isAddRequest.value
                            ? supportRequestController.supportLists.length + 1
                            : supportRequestController.supportLists.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data =
                              supportRequestController.supportLists[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(top: 15, right: 5.w, left: 5.w),
                            child: InkWell(
                              onTap: () {
                                // Get.to(RequestDetails());
                              },
                              child: Container(
                                width: 100.w,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ListTile(
                                    isThreeLine: false,
                                    title: Text("Request No ${data.id}",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    subtitle: Row(
                                      children: [
                                        Text("Status"),
                                        Text(
                                          "   ${data.status}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "2 Days Ago",
                                          style: GoogleFonts.roboto(
                                              color: Color.fromARGB(
                                                  255, 139, 138, 138),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  );
                })
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Get.to(AddRequest());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(
                              '  Raise new Query',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2110513051,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
