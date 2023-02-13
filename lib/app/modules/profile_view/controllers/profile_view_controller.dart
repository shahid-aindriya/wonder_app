import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/urls.dart';
import '../model/userdata_response.dart';

class ProfileViewController extends GetxController {
  //TODO: Implement ProfileViewController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  RxList<UserData> userDetailLists = <UserData>[].obs;
  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-profile-view/"),
        headers: headers,
        body: jsonEncode(body));
    log("sdfgsdfgs${request.body}");
    if (request.statusCode == 201) {
      final userDataResponse = userDataResponseFromJson(request.body);
      userDetailLists.assign(userDataResponse.userData);
    }
  }
}
