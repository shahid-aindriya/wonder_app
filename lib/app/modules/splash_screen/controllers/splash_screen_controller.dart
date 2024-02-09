import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    bool alreadyCleared = pref.getBool('dataCleared1') ?? false;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = pref.getString('currentVersion');
    final updatedVersion = packageInfo.version;
    if (loggedName == null ||
        !alreadyCleared ||
        currentVersion != updatedVersion) {
      await pref.clear();
      await pref.setBool('dataCleared1', true);
      await gotoLogin();
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Get.offAll(() => BottombarView(), transition: Transition.fade);
    }
    return loggedName;
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(LoginView());
  }
}
