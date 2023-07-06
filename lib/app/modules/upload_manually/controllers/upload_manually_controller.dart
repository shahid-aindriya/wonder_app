import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/seller_regist/controllers/seller_regist_controller.dart';

import '../../../data/urls.dart';

class UploadManuallyController extends GetxController {
  //TODO: Implement UploadManuallyController
  final SellerRegistController sellerRegistController =
      Get.put(SellerRegistController());
  final TextEditingController amountEditingController = TextEditingController();

  final count = 0.obs;

  void increment() => count.value++;

  String screenShot = '';
  File? image3;
  pickimage2() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      final ims = await sellerRegistController.cropsImage(pimage.path);

      final bytes = File(ims.path).readAsBytesSync();
      final compressedimage = testComporessList(bytes);
      screenShot = base64Encode(await compressedimage);
    }
    log("panimg");
    update();
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 100,
      format: CompressFormat.jpeg,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  var isUploadLoading = false.obs;
  uploadManually(amount, context) async {
    final body = {
      "shop_id": invoiceController.selectShopId,
      "amount": 100,
      "image": screenShot
    };
    isUploadLoading.value = true;
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-shop-manual-payment/"),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      if (data['success'] == false) {
        Get.snackbar("Error", data['message'], backgroundColor: Colors.red);
        isUploadLoading.value = false;
        return;
      } else if (data['success'] == true) {
        screenShot = "";
        amountEditingController.clear();
        update();
        MotionToast.success(
          dismissable: true,
          enableAnimation: false,
          position: MotionToastPosition.top,
          title: const Text(
            'Success ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          description: const Text('Uploaded Successfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
        Get.back();
      }
    }
  }
//  FirebaseFireStore
}
