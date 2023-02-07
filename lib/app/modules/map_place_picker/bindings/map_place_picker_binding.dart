import 'package:get/get.dart';

import '../controllers/map_place_picker_controller.dart';

class MapPlacePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapPlacePickerController>(
      () => MapPlacePickerController(),
    );
  }
}
