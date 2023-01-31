import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wonder_app/app/modules/add_invoice/models/all_user_model.dart';

import '../../../data/urls.dart';

class AddInvoiceController extends GetxController {
  //TODO: Implement AddInvoiceController
  @override
  void onInit() {
    getAllUsers();
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  String? selectUserId;
  changeUser(dynamic value) {
    selectUserId = null;
    selectUserId = value;
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
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      invoiceImg = base64Encode(bytes);
    }
    // log(img);
    update();
  }
}
