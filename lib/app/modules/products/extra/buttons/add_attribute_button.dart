import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/products/controllers/products_controller.dart';
import 'package:wonder_app/app/modules/products/extra/add_attribute.dart';

class AddAttributeButton extends StatelessWidget {
  const AddAttributeButton(
      {super.key, required this.productsController, required this.productId});
  final ProductsController productsController;
  final productId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 4.w),
      child: InkWell(
        onTap: () {
          Get.to(AddAttributeView(
            productsController: productsController,
            productId: productId,
          ));
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          color: Color(0xe53f46bd),
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Color.fromARGB(117, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Color(0xe53f46bd),
                ),
                Text(
                  '  Add Attribute',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.2110513051,
                    color: Color(0xe53f46bd),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
