import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/urls.dart';

class BankDetailsController extends GetxController {
  //TODO: Implement BankDetailsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  String chequeImage = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      chequeImage = base64Encode(bytes);
    }
    // log(img);
    update();
  }

  addBankDetails({shopId, int? accountNum, accType, ifscCode, name}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {
      "name": name,
      "user_id": userId,
      "shop_id": shopId,
      "account_number": accountNum,
      "account_type": "current",
      "ifsc_code": ifscCode,
      "cheque_copy": chequeImage
    };
    var request = await http.post(Uri.parse("${baseUrl.value}vendor-add-shop/"),
        headers: headers, body: jsonEncode(body));
    log(request.body.toString());
  }
}
