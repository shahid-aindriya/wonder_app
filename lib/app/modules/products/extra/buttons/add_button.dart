import 'package:flutter/material.dart';

import '../../controllers/products_controller.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.productsController,
    required this.onClick,
  });
  final Function() onClick;
  final ProductsController productsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
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
              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: onClick,
          child: Text("Add Attribute")),
    );
  }
}
