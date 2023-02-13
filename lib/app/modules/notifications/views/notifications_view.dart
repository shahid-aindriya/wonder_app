import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../invoice/controllers/invoice_controller.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  final InvoiceController? invoiceController;

  NotificationsView({this.invoiceController});
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
            backgroundColor: Colors.transparent,
            elevation: 0,
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
            title: Text(
              'Notifications',
              style: GoogleFonts.jost(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Color.fromARGB(255, 73, 86, 178)),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment(
                                    1.1437236070632935, -0.005003529135137796),
                                end: Alignment(
                                    -0.06076670065522194, 0.042849887162446976),
                                colors: [
                                  Color.fromRGBO(255, 255, 255, 0.75),
                                  Color.fromRGBO(
                                      255, 255, 255, 0.3199999928474426)
                                ]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      radius: 24,
                                      child: Image.asset(
                                          "assets/images/Ellipse 21.png")),
                                ],
                              ),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'You have received new invoice approval request by ',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          wordSpacing: 1,
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    TextSpan(
                                      text: 'Rakhesh k Raju',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("2 Minutes Ago",
                                        style: GoogleFonts.roboto(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300))
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
