import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/my_shops/controllers/my_shops_controller.dart';
import 'package:wonder_app/app/modules/seller_regist/controllers/seller_regist_controller.dart';

import '../../../data/urls.dart';
import '../../bank_details/models/bank_add_response.dart';
import '../../store_details/model/store_category_model.dart';
import '../../success/views/success_view.dart';
import '../model/offer_data_response.dart';

class ShopDetailsController extends GetxController {
  //TODO: Implement ShopDetailsController

  final count = 0.obs;
  @override
  void onInit() {
    getShopCategories();
    // TODO: implement onInit
    super.onInit();
  }

  bool? isChecked;
  checkBox(value) {
    isChecked = value;
    update();
  }

  dynamic shopId;
  String? categoryId;
  editShopDetails(
      {shopId,
      gstNumber,
      lat,
      long,
      licenceNumber,
      commission,
      gstPct,
      location,
      address,
      shopName,
      context,
      MyShopsController? contorller}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");

    int catId = int.tryParse(categoryId!)!;
    // log(catId.toString());
    log(shopName);
    var gstimage = gstImage == '' ? null : gstImage;
    var shopimage = shopImage == '' ? null : shopImage;
    var licenceimage = licenceImage == '' ? null : licenceImage;
    var body = {
      "shop_id": shopId,
      "name": shopName,
      "user_id": userId,
      "category_id": catId,
      "gst_number": gstNumber,
      "address": address,
      "location": location,
      "latitude": lat,
      "longitude": long,
      "commission": commission,
      "gst_pct": gstPct,
      "license_number": licenceNumber,
      "featured_image": shopimage,
      "gst_image": gstimage,
      "license_image": licenceimage,
      "is_featured": isChecked
    };
    try {
      var request = await http.post(
          Uri.parse("https://wonderpoints.com/vendor-edit-shop/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        await contorller!.getListOfShops();
        shopImage = '';
        gstImage = '';
        licenceImage = '';

        Get.back();
        Get.back();
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
          description: const Text('Shop edited Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  deleteShop({bankid, MyShopsController? controller, context}) async {
    var body = {"bank_id": bankid};
    var request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-shop/"),
        headers: headers,
        body: jsonEncode(body));
    log(request.body);
    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      if (data['success'] == true) {
        await controller!.getListOfShops();
        Get.back();
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
          description: const Text('Deleted Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
  }

  deleteOffer(offerId, context) async {
    var body = {"offer_id": offerId};
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-delete-shop-offer/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.statusCode.toString());
      if (request.statusCode == 201) {
        await getOffers();
        Get.back();
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
          description: const Text('Deleted Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  RxList<OfferDatum> offerdatas = <OfferDatum>[].obs;
  getOffers() async {
    var body = {"shop_id": shopId};
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-get-all-shop-offers/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
      if (request.statusCode == 201) {
        final offerDataResponse = offerDataResponseFromJson(request.body);
        offerdatas.assignAll(offerDataResponse.offerData);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  String offerImage = '';
  File? image;
  dynamic compressedImage;

  pickimage(value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);
      final ims = await SellerRegistController().cropsImage(pimage.path);
      if (ims != null) {
        final bytes = File(ims.path).readAsBytesSync();

        compressedImage = testComporessList(bytes);
        offerImage = base64Encode(await compressedImage);
        update();
        return;
      } else {
        return;
      }
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 70,
      format: CompressFormat.jpeg,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  addOffers({name, shopId, discount, descpition, context}) async {
    log(shopId.toString());

    if (offerImage == '') {
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
        description: const Text('please add image'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
      return;
    }
    var body = {
      "name": name,
      "shop_id": shopId,
      "discount": discount,
      "description": descpition,
      "image": offerImage
    };
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-add-shop-offer/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());
      if (request.statusCode == 201) {
        final datas = jsonDecode(request.body);
        if (datas['success'] == true) {
          await getOffers();
          offerImage = '';
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
            description: const Text('offer added Succesfully'),
            animationCurve: Curves.bounceIn,
            borderRadius: 0,
            animationDuration: const Duration(milliseconds: 1000),
          ).show(context);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  editOffers({offerId, context, name, discount, description}) async {
    log(shopId.toString());
    var checkimage = checkImage == '' ? null : checkImage;
    var body = {
      "offer_id": offerId,
      "name": name,
      "shop_id": shopId,
      "discount": discount,
      "description": description,
      "image": checkimage
    };
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-edit-shop-offer/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
      if (request.statusCode == 201) {
        await getOffers();
        offerImage = '';
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
          description: const Text('offer edited Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  var categoryLists = RxList<ShopCategory>().obs;
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

  String shopImage = '';
  File? image2;
  dynamic compressedShopImage;

  pickShopImage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image2 = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedShopImage = testComporessList(bytes);
      shopImage = base64Encode(await compressedShopImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  String licenceImage = '';
  File? image3;
  dynamic compressedLicenceImage;

  pickLicenceImage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image3 = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedLicenceImage = testComporessList(bytes);
      licenceImage = base64Encode(await compressedLicenceImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  String gstImage = '';
  File? image4;
  dynamic compressedGstImage;

  pickGstImage(bool value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image4 = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedGstImage = testComporessList(bytes);
      gstImage = base64Encode(await compressedGstImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  String checkImage = '';
  File? image5;
  dynamic compressedcheckImage;

  pickCheckImage(value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image5 = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedcheckImage = testComporessList(bytes);
      checkImage = base64Encode(await compressedcheckImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  editBankDetails({bankId, name, accnumber, acctype, ifsc}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var check = checkImage == '' ? null : checkImage;
    // log(bankId.toString());
    var body = {
      "bank_id": bankId,
      "name": name,
      "user_id": userId,
      "shop_id": shopId,
      "account_number": accnumber,
      "account_type": acctype,
      "ifsc_code": ifsc,
      "cheque_copy": check
    };
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-edit-bank-details/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body);
      if (request.statusCode == 201) {
        final bankaddresponse = jsonDecode(request.body);
        if (bankaddresponse['success'] == true) {
          Get.to(SuccessView());
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  addBankDetailss({int? accountNum, accType, ifscCode, name, context}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    // log(name);
    final box = FlutterSecureStorage();
    final shopIds = await box.read(key: 'shopId');
    log(shopIds!);
    // log(accountNum.toString());
    // log(ifscCode);
    int id = int.tryParse(shopIds)!;
    if (checkImage == "") {
      MotionToast.warning(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Error ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text('Please Upload cheque image'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
      return;
    }
    var body = {
      "name": name,
      "user_id": userId,
      "shop_id": id,
      "account_number": accountNum,
      "account_type": accType,
      "ifsc_code": ifscCode,
      "cheque_copy": checkImage
    };
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-add-bank/"),
          headers: headers,
          body: jsonEncode(body));
      log(request.body.toString());

      if (request.statusCode == 201) {
        final bankaddresponse = bankaddresponseFromJson(request.body);
        if (bankaddresponse.success == true) {
          Get.to(SuccessView());
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  showPopup(context, Function(bool value) pickShopImage) {
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
                    pickShopImage(true);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickShopImage(false);
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
}
