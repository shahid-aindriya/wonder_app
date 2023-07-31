import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/bottom_bar/views/bottom_bar_view.dart';
import 'package:wonder_app/app/modules/login/views/login_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;

  void increment() => count.value++;

  Future<int?> checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    final loggedName = pref.getInt('userId');
    if (loggedName == null) {
      gotoLogin();
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Get.off(BottombarView());
    }
    return loggedName;
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.off(LoginView());
  }
}
