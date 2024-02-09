import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import 'package:wonder_app/app/modules/products/controllers/products_controller.dart';
import 'package:wonder_app/app/modules/products/model/attribute_single_add_model.dart';
import 'package:wonder_app/app/modules/products/model/single_attribute_model.dart';
import 'package:wonder_app/app/modules/products/views/products_view.dart';
import 'package:wonder_app/app/modules/seller_regist/controllers/seller_regist_controller.dart';

class AttributeController extends GetxController {
  final SellerRegistController sellerRegistController =
      Get.put(SellerRegistController());

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

  pickimage(bool value, isADdOrEdit) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    }
    // final editImageFile = File(pimage.path);
    final ims = await sellerRegistController.cropsImage(pimage.path);
    if (ims != null) {
      if (isADdOrEdit == true) {
        final newImg = File(ims.path);

        multiImages.add(newImg);
        update();
        return;
      } else {
        final newImg = File(ims.path);
        final SingleAttributeImage allImage =
            SingleAttributeImage(image: newImg);
        attributeImageList.add(allImage);
        imageEditList.add(newImg);
        update();
        return;
      }
    }
  }
  // log(img);

  showPopup(context, isADdOrEdit) {
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
                    pickimage(true, isADdOrEdit);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false, isADdOrEdit);
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
            imageEditList.add(compressedImage);
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
        targetWidth: 225,
        targetHeight: 225);
    // File compressedFile = await FlutterNativeImage.compressImage(
    //     compressedFile2.path,
    //     quality: 100,
    //     percentage: 70);
    // File compressedFile = await FlutterNativeImage.compressImage(imageFile.path,
    //     quality: 100, percentage: 100);
    return compressedFile2;
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

  addAttribute(id, context, ProductsController productsController) async {
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

      await productsController.getProductDetails(id);
      await productsController
          .getListOfPrdoucts(invoiceController.selectShopId);
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

  RxList<SingleAttributeImage> attributeImageList =
      <SingleAttributeImage>[].obs;
  RxList<File> imageEditList = <File>[].obs;
  RxList<AttributeData> singleAttributeDetailsList = <AttributeData>[].obs;
  getAttributeDetails(id) async {
    final body = {"attribute_id": id};

    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-get-product-attribute-data/"),
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
      final singleAttributeDetailsModel =
          singleAttributeDetailsModelFromJson(request.body);
      singleAttributeDetailsList
          .assign(singleAttributeDetailsModel.attributeData);
      attributeImageList
          .assignAll(singleAttributeDetailsModel.attributeData.image);
    }
  }

  dynamic editAttributeId;

  updateAttribute(
      {context, id, value, price, discount, quantity, attributeId}) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl.value}vendor-edit-product-attribute/"),
    );
    log(editAttributeId.toString());
    isAttributeLoading.value = true;
    request.fields['id'] = attributeId.toString();
    request.fields['attribute_id'] = editAttributeId.toString();
    request.fields['value'] = value.toString();
    request.fields['price'] = price.toString();
    request.fields['discount'] = discount.toString();
    request.fields['quantity'] = quantity.toString();

    // request.files.add(await http.MultipartFile.fromPath("image", image!.path));

    for (int i = 0; i < imageEditList.length; i++) {
      File image = imageEditList[i];
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
    log(responseBody.toString());
    if (response.statusCode == 201) {
      await productsController.getProductDetails(id);
      await getAttributeDetails(attributeId);
      await productsController
          .getListOfPrdoucts(invoiceController.selectShopId);
      await getAttributeList(id);
      isAttributeLoading.value = false;
      imageEditList.clear();
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
        description: const Text('Attribute Updated Successfully'),
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

  removeAttributeImage(imageId, id, context, index) async {
    if (attributeImageList.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Atleast one image required',
              style: GoogleFonts.roboto(
                  fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      );
      return;
    }
    if (attributeImageList[index].id == null) {
      attributeImageList.removeAt(index);

      return;
    }

    final body = {"image_id": imageId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-attribute-image/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 200) {
      await getAttributeDetails(id);
    }
    await getAttributeDetails(id);
  }

  selectFromDropDown(value) {
    editAttributeId = value;
    update();
  }
}
