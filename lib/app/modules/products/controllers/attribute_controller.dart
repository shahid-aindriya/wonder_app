import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/products/model/attribute_single_add_model.dart';
import 'package:wonder_app/app/modules/products/model/edit_product_details_model.dart';

class AttributeController extends GetxController {
  dynamic attributeId;
  final TextEditingController editValueAttributeController =
      TextEditingController();
  final TextEditingController editQuantityAttributeController =
      TextEditingController();

  final TextEditingController editAttributeDiscountEditingController =
      TextEditingController();
  final TextEditingController editAttributePriceEditingController =
      TextEditingController();
  var isAttributeLoading = false.obs;
  RxList<File> multiImages = <File>[].obs;
  selectMultipleImages() async {
    try {
      List<XFile> pimage = await ImagePicker()
          .pickMultiImage(imageQuality: 80, maxHeight: 1080, maxWidth: 1920);
      if (pimage.isEmpty) {
        return;
      } else {
        if (pimage.isNotEmpty) {
          for (var i = 0; i < pimage.length; i++) {
            File imageFile = File(pimage[i].path);
            File compressedImage = await compressImage(imageFile);
            multiImages.add(compressedImage);
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  compressImage(File imageFile) async {
    // ImageProperties properties =
    //     await FlutterNativeImage.getImageProperties(imageFile.path);
    File compressedFile2 = await FlutterNativeImage.compressImage(
        imageFile.path,
        quality: 80,
        targetWidth: 600,
        targetHeight: 700);
    File compressedFile = await FlutterNativeImage.compressImage(
        compressedFile2.path,
        quality: 100,
        percentage: 70);
    // File compressedFile = await FlutterNativeImage.compressImage(imageFile.path,
    //     quality: 100, percentage: 100);
    return compressedFile;
  }

  RxList<Attribute> editAttributesList = <Attribute>[].obs;
  getAttributeList(id) async {
    final body = {"product_id": id};

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-list-shop-product-attributes/"),
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
      final attributeModel = attributeModelFromJson(request.body);
      editAttributesList.assignAll(attributeModel.attributes);
      log(editAttributesList.toString());
      update();
    }
  }

  addAttribute(id, context) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl.value}vendor-add-product-attribute/"),
    );

    isAttributeLoading.value = true;
    request.fields['product_id'] = id.toString();
    request.fields['attribute_id'] = attributeId.toString();
    request.fields['value'] = editValueAttributeController.text.toString();
    request.fields['price'] =
        editAttributePriceEditingController.text.toString();
    request.fields['discount'] =
        editAttributeDiscountEditingController.text.toString();
    request.fields['quantity'] =
        editQuantityAttributeController.text.toString();

    // request.files.add(await http.MultipartFile.fromPath("image", image!.path));

    for (int i = 0; i < multiImages.length; i++) {
      File image = multiImages[i];
      request.files.add(
        await http.MultipartFile.fromPath(
          'image[$i]',
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    log(response.statusCode.toString());
    // log(responseBody.toString());
    if (response.statusCode == 201) {
      await getAttributeList(id);
      attributeId = null;
      editValueAttributeController.clear();
      editAttributePriceEditingController.clear();
      editAttributeDiscountEditingController.clear();
      editQuantityAttributeController.clear();
      multiImages.clear();
      isAttributeLoading.value = false;

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
        description: const Text('Attribute added Successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
      update();
    } else {
      isAttributeLoading.value = false;
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
        description: const Text('Cannot add right now'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
  }
}
