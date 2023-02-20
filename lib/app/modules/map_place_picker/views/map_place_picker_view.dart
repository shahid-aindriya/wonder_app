import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../store_details/views/store_details_view.dart';
import '../controllers/map_place_picker_controller.dart';

class MapPlacePickerView extends GetView<MapPlacePickerController> {
  MapPlacePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationDatas datas = Get.arguments;
    return Scaffold(
      body: PlacePicker(
        apiKey: "AIzaSyB1wjIvMb5foy65Etk2JeVhHK_NVgxT8ho",
        useCurrentLocation: true,
        initialPosition: LatLng(9.9312328, 76.26730410000005),
        forceSearchOnZoomChanged: true,
        hintText: "Find a place ...",
        searchingText: "Please wait ...",
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        selectedPlaceWidgetBuilder: (
          context,
          selectedPlace,
          state,
          isSearchBarFocused,
        ) {
          return isSearchBarFocused
              ? Container()
              : FloatingCard(
                  bottomPosition: 0.0,
                  leftPosition: 0.0,
                  rightPosition: 0.0,
                  child: state == SearchingState.Searching
                      ? Container()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            selectedPlace == null
                                ? Container()
                                : Container(
                                    height: 130,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          selectedPlace.formattedAddress
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        MaterialButton(
                                          onPressed: () {
                                            // log(selectedPlace
                                            //     .geometry!.location.lat
                                            //     .toString());
                                            // log(selectedPlace.geometry!.viewport
                                            //     .toString());
                                            // Get.off(StoreDetailsView(
                                            //   storeLocation: selectedPlace
                                            //       .formattedAddress,
                                            // ));

                                            // String s = '';
                                            // for (var i = 0;
                                            //     i <
                                            //         selectedPlace
                                            //             .addressComponents!
                                            //             .length;
                                            //     i++) {
                                            //   log(selectedPlace
                                            //       .addressComponents![i]
                                            //       .shortName);
                                            //   s = "$s${selectedPlace.addressComponents![i].shortName} ,";
                                            // }
                                            datas.location!.text =
                                                selectedPlace.formattedAddress!;
                                            datas.lat!.text = selectedPlace
                                                .geometry!.location.lat
                                                .toString();
                                            datas.long!.text = selectedPlace
                                                .geometry!.location.lat
                                                .toString();
                                            Get.back();
                                          },
                                          // ignore: sort_child_properties_last
                                          child: Text("Select Place"),

                                          minWidth: 200,
                                          height: 45,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.green,
                                        )
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                );
        },
      ),
    );
  }
}
