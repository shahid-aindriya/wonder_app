import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../upload_manually/views/upload_manually_view.dart';

class PayManually extends StatelessWidget {
  const PayManually({super.key, required this.amount});
  final amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin:
                          Alignment(1.1437236070632935, -0.005003529135137796),
                      end:
                          Alignment(-0.06076670065522194, 0.042849887162446976),
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.75),
                        Color.fromRGBO(255, 255, 255, 0.3199999928474426)
                      ]),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () async {
                          Get.to(UploadManuallyView(
                            amount: amount,
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pay Manually",
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 73, 117, 231)),
                            ),
                            Text(
                              "Pay by uploading screenshot",
                              style: GoogleFonts.roboto(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 73, 117, 231)),
                            ),
                          ],
                        )))),
          ),
        ],
      ),
    );
  }
}
