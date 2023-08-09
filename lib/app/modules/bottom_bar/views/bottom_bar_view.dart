import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wonder_app/app/modules/chat/views/chat_view.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/products/views/products_view.dart';

import '../../my_earnings/views/my_earnings_view.dart';
import '../../orders/views/orders_view.dart';
import '../controllers/bottom_bar_controller.dart';

class BottombarView extends GetView<BottomBarController> {
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final pages = [
      InvoiceView(),
      OrdersView(),
      ProductsView(),
      MyEarningsView(),
      ChatView()
    ];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(2, 1.0548897981643677),
            end: Alignment(-1.0548897981643677, 1.226324439048767),
            colors: [
              Color.fromRGBO(239, 221, 214, 1),
              Color.fromRGBO(220, 222, 242, 1),
              Color.fromRGBO(250, 227, 243, 1),
              Color.fromRGBO(228, 249, 254, 1)
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: BottombarView.selectedPageIndex,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: BottomNavigationBar(
                  elevation: 19,
                  unselectedItemColor: Color.fromARGB(
                    255,
                    181,
                    181,
                    181,
                  ),
                  selectedItemColor: Color.fromARGB(
                    255,
                    80,
                    119,
                    221,
                  ),
                  backgroundColor: Color.fromARGB(255, 234, 234, 234),
                  currentIndex: updatedIndex,
                  onTap: ((newIndex) {
                    BottombarView.selectedPageIndex.value = newIndex;
                  }),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: CustomSvgIcon(
                          assetPath: selectedPageIndex.value == 0
                              ? 'assets/images/bottom/home-2.svg'
                              : 'assets/images/bottom/home.svg',
                          size: 24,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: CustomSvgIcon(
                          assetPath: selectedPageIndex.value == 1
                              ? 'assets/images/bottom/orders-2.svg'
                              : 'assets/images/bottom/orders.svg',
                          size: 24,
                        ),
                        label: 'Orders'),
                    BottomNavigationBarItem(
                        icon: CustomSvgIcon(
                          assetPath: selectedPageIndex.value != 2
                              ? 'assets/images/bottom/products.svg'
                              : 'assets/images/bottom/products-2.svg',
                          size: 24,
                        ),
                        label: 'Products'),
                    BottomNavigationBarItem(
                        icon: CustomSvgIcon(
                          assetPath: selectedPageIndex.value != 3
                              ? 'assets/images/bottom/commission.svg'
                              : 'assets/images/bottom/commission-2.svg',
                          size: 24,
                        ),
                        label: 'Commisson'),
                    BottomNavigationBarItem(
                        icon: CustomSvgIcon(
                          assetPath: selectedPageIndex.value != 4
                              ? 'assets/images/bottom/chat_unselected.svg'
                              : 'assets/images/bottom/chat_selected.svg',
                          size: 24,
                        ),
                        label: 'Chats'),
                  ]),
            );
          },
        ),
        body: ValueListenableBuilder(
          valueListenable: selectedPageIndex,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return pages[updatedIndex];
          },
        ),
      ),
    );
  }
}

class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;

  CustomSvgIcon({required this.assetPath, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,
      ),
    );
  }
}
