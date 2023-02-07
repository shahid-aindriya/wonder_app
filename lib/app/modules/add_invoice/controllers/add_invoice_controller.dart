import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/models/all_user_model.dart';
import '../../../data/urls.dart';
import '../../my_shops/model/shops_list_model.dart';

class AddInvoiceController extends GetxController {
  //TODO: Implement AddInvoiceController
  @override
  void onInit() {
    getAllUsers();
    getListOfShops();
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  String? selectUserId;
  dynamic selectShopId;
  final TextEditingController invoiceNumber = TextEditingController();
  final TextEditingController invoiceDAte = TextEditingController();
  final TextEditingController preTaxController = TextEditingController();
  final TextEditingController invoiceAmountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  changeUser({dynamic value, id}) {
    log(selectUserId.toString());
    selectUserId = null;

    selectUserId = value;

    update();
  }

  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }

  var userLists = RxList<UsersDatum>().obs;
  Future<dynamic> getAllUsers() async {
    var request = await http.get(
      Uri.parse("${baseUrl.value}get-all-users/"),
      headers: headers,
    );

    log(request.body);
    if (request.statusCode == 201) {
      final allUsersList = allUsersListFromJson(request.body);
      userLists.value.assignAll(allUsersList.usersData);
    }
  }

  String invoiceImg = '';
  File? image;
  dynamic compressedImage;
  dynamic newImage;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedImage = testComporessList(bytes);
      invoiceImg = base64Encode(await compressedImage);
      log(invoiceImg);
    }
    // log(img);
    update();
  }

  var isLoading = false.obs;
  addInvoice(context) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");

    var body = {
      "customer_id": selectUserId,
      "user_id": userId,
      "shop_id": selectShopId,
      "invoice_image": invoiceImg,
      "invoice_number": invoiceNumber.text,
      "invoice_date": invoiceDAte.text,
      "pre_tax_amount": preTaxController.text,
      "invoice_amount": invoiceAmountController.text,
      "remark": remarksController.text
    };
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-add-invoice/"),
        headers: headers,
        body: json.encode(body));
    log(request.statusCode.toString());
    // log(request.body.toString());
    if (request.statusCode == 201) {
      selectUserId = null;
      invoiceImg = '';
      selectShopId = null;
      invoiceAmountController.clear();
      invoiceDAte.clear();
      invoiceNumber.clear();
      preTaxController.clear();
      remarksController.clear();
      invoiceDAte.clear();
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
        description: const Text('Invoice added Succesfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }

    isLoading.value = false;
  }

  var shopLists = RxList<ShopDatum>().obs;
  Future<dynamic> getListOfShops() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId.toString()};
    var request = await http.post(Uri.parse("${baseUrl.value}vendor-all-shop/"),
        headers: headers, body: jsonEncode(body));
    // log(request.statusCode.toString());
    if (request.statusCode == 201) {
      final shopsListModel = shopsListModelFromJson(request.body);
      // log(shopsListModel.shopData[0].licenseImage.toString());
      shopLists.value.assignAll(shopsListModel.shopData);
      return shopsListModel.shopData;
    }
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 500,
      minWidth: 400,
      quality: 70,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }
}
