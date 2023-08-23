import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/verified_model.dart';

class ShopBalance extends StatelessWidget {
  const ShopBalance({
    super.key,
    required this.amount,
  });

  final TotalAmountData amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 229, 223, 227)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 10, right: 10),
                child: AutoSizeText(
                  maxLines: 1,
                  "₹${amount.shopBalance}",
                  textAlign: TextAlign.center,
                  maxFontSize: 23,
                  minFontSize: 16,
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 73, 117, 231),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
