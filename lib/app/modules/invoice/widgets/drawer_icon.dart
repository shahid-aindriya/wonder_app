import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator DrawerIcon - GROUP
    return Container(
        width: 57,
        height: 42,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                          offset: Offset(0, 0.8400000333786011),
                          blurRadius: 3.3600001335144043)
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/images/Ellipse15.png'),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.elliptical(42, 42)),
                  ))),
          Positioned(
              top: 9,
              left: 33,
              child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.all(Radius.elliptical(24, 24)),
                  ))),
          Positioned(
              top: 16,
              left: 38,
              child: Container(
                  width: 14,
                  height: 10,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 14,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ))),
                    Positioned(
                        top: 4,
                        left: 0,
                        child: Container(
                            width: 14,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ))),
                    Positioned(
                        top: 8,
                        left: 0,
                        child: Container(
                            width: 14,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ))),
                  ]))),
        ]));
  }
}
