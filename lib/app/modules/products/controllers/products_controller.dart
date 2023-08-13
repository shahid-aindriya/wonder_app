import 'package:get/get.dart';

class ProductsController extends GetxController {
  //TODO: Implement ProductsController

  final count = 0.obs;

  void increment() => count.value++;
  var switchValue = false.obs;
  switchChange(value) {
    switchValue.value = value;
  }

 List<String> unitList = ['Number', 'Digit'];

  List<String> categoryList = ['Detergents', 'Soaps'];

  List<String> sortList = ['Availability', 'Relevence'];
  dynamic selectedValue;
  dynamic sortValue;
}
