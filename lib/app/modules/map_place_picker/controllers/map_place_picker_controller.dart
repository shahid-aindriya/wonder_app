import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapPlacePickerController extends GetxController {
  //TODO: Implement MapPlacePickerController

  final count = 0.obs;

  void increment() => count.value++;

  Future<Position?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
      return position;
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }
}
