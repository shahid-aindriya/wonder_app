import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
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
      final compressedImage = testComporessList(bytes);
      shopImage = base64Encode(await compressedImage);
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

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 100,
      format: CompressFormat.png,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

 
 
 


}
