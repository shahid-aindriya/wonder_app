import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../data/urls.dart';
import '../model/notification_response.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;

  RxList<NotificationDatum> notificationList = <NotificationDatum>[].obs;
  Future<dynamic> notifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId};
    try {
      final request = await http.post(
          Uri.parse("${baseUrl.value}vendor-notifications/"),
          body: jsonEncode(body),
          headers: headers);
      log("fgf${request.body}");
      if (request.statusCode == 201) {
        final notificationresponse = notificationresponseFromJson(request.body);
        notificationList.assignAll(notificationresponse.notificationData);
        return true;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }
}
