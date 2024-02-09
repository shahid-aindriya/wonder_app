import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/orders/controllers/orders_controller.dart';

class AcceptAndRejectReturn extends StatelessWidget {
  const AcceptAndRejectReturn({
    super.key,
    required this.id,
    required this.ordersController,
  });
  final OrdersController ordersController;
  final id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 10, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(117, 255, 255, 255),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.only(top: 15.0, left: 4.w, right: 4.w, bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "User is requesting return due to damaged product",
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Column(
                    children: [
                      Text("15 Oct,2023",
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 14)),
                      Text("10:15 pm",
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 14))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment(
                              0.8374384045600891, 0.11822659522294998),
                          end: Alignment(
                              -0.11822660267353058, 0.10431758314371109),
                          colors: [
                            Color.fromRGBO(63, 70, 189, 1),
                            Color.fromRGBO(65, 125, 232, 1)
                          ]),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () async {
                          ordersController.changeProductStatus(context,
                              orderId: id, status: "Return Accepted");
                        },
                        child: Text("Accept",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 198, 198, 198)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(100, 40)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          ordersController.changeProductStatus(context,
                              orderId: id, status: "Reject");
                        },
                        child: Text(
                          "Reject",
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
