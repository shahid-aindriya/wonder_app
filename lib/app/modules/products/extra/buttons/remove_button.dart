import 'package:flutter/material.dart';

import '../../controllers/products_controller.dart';

class RemoveButton extends StatelessWidget {
  RemoveButton(
      {super.key,
      required this.productsController,
      this.visibility,
      required this.onTap});

  final ProductsController productsController;
  dynamic visibility;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility ?? true,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(),
          color: Colors.red,
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
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
            onPressed: onTap,
            child: Text("Remove")),
      ),
    );
  }
}
