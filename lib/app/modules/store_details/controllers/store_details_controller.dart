import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/modules/seller_regist/controllers/seller_regist_controller.dart';
import 'package:wonder_app/app/modules/store_details/model/store_category_model.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

class StoreDetailsController extends GetxController {
  final SellerRegistController sellerRegistController =
      Get.put(SellerRegistController());
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
  pickimage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      final ims = await sellerRegistController.cropsImage(pimage.path);
      final bytes = File(ims.path).readAsBytesSync();
      final compressedImage = testComporessList(bytes);
      shopImage = base64Encode(await compressedImage);
      update();
    }
    // log(img);
    update();
  }

  Future<dynamic> getShopCategories() async {
    try {
      var request = await http.get(
        Uri.parse("${baseUrl.value}get-all-categories/"),
        headers: headers,
      );

      log(request.body);
      if (request.statusCode == 201) {
        final shopShopCategoryModel =
            shopShopCategoryModelFromJson(request.body);
        categoryLists.value.assignAll(shopShopCategoryModel.categories);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 400,
      minWidth: 400,
      quality: 80,
      format: CompressFormat.jpeg,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  showPopup(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () {
                    pickimage(true);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false);
                    // Handle the 'Choose from gallery' option
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  alertPopu({context, required data}) {
    MotionToast.error(
      dismissable: true,
      enableAnimation: false,
      position: MotionToastPosition.top,
      title: const Text(
        'Error ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(data),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
  }
}
