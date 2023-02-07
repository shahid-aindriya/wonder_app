import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonder_app/app/modules/store_details/model/store_category_model.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

class StoreDetailsController extends GetxController {
  //TODO: Implement StoreDetailsController
  @override
  void onInit() {
    getShopCategories();
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;
  bool isChecked = false;
  @override
  void onClose() {}
  void increment() => count.value++;

  String? categoryId;
  var categoryLists = RxList<ShopCategory>().obs;

  checkBox(value) {
    isChecked = value;
    update();
  }

  changeCategory({value}) {
    categoryId = null;
    categoryId = value;
    update();
  }

  String shopImage = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      shopImage = base64Encode(bytes);
    }
    // log(img);
    update();
  }

  Future<dynamic> getShopCategories() async {
    var request = await http.get(
      Uri.parse("${baseUrl.value}get-all-categories/"),
      headers: headers,
    );

    log(request.body);
    if (request.statusCode == 201) {
      final shopShopCategoryModel = shopShopCategoryModelFromJson(request.body);
      categoryLists.value.assignAll(shopShopCategoryModel.categories);
    }
  }
}
