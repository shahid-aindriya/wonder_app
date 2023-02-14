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

import '../../../data/urls.dart';
import '../model/userdata_response.dart';

class ProfileViewController extends GetxController {
  //TODO: Implement ProfileViewController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  RxList<UserData> userDetailLists = <UserData>[].obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Future<dynamic> getUserData() async {
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
      nameController.text = userDetailLists.first.name;
      numberController.text = userDetailLists.first.phone;
      emailController.text = userDetailLists.first.email;
      update();
    }
  }

  dynamic compressedImage;
  String profileImage = '';
  File? image;
  pickimage() async {
    final pimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();
      compressedImage = testComporessList(bytes);
      profileImage = base64Encode(await compressedImage);
      update();
    }
    // log(img);
    update();
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 100,
      format: CompressFormat.png,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  editProfile({context}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {
      "user_id": userId,
      "name": nameController.text,
      "email": emailController.text,
      "phone": numberController.text,
      "image": profileImage
    };
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-profile-edit/"),
        headers: headers,
        body: jsonEncode(body));

    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      if (data['success'] == true) {
        getUserData();
        // log(request.body);
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
          description: const Text('profile updated Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    }
  }
}
