import 'package:get/get.dart';

class OrdersController extends GetxController {
  //TODO: Implement OrdersController

  final count = 0.obs;

  void increment() => count.value++;
  RxInt selectedCard = (-1).obs;
  selectCard(value) {
    selectedCard.value = value;
  }
}
