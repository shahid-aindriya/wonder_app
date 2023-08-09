import 'package:get/get.dart';

class ChooseVendorController extends GetxController {
  //TODO: Implement ChooseVendorController

  final count = 0.obs;

  void increment() => count.value++;
  RxBool selected = false.obs;

  selectValue(value) {
    selected.value = value;
    update();
  }
}
