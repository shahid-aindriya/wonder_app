import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AcceptedReturnWidget extends StatelessWidget {
  const AcceptedReturnWidget({
    super.key,
  });

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "You’ve accepted the request for return. Change order status to completed once item is returned",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
