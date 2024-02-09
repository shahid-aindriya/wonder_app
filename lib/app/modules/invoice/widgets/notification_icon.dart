import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BellWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator BellWidget - GROUP
    return Container(
        width: 45,
        height: 35,
        child: SvgPicture.asset(
          'assets/images/notification_bell.svg',
          fit: BoxFit.fitHeight,
        ));
  }
}
