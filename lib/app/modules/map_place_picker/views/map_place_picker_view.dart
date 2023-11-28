import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../store_details/views/store_details_view.dart';
import '../controllers/map_place_picker_controller.dart';

class MapPlacePickerView extends GetView<MapPlacePickerController> {
  MapPlacePickerView({super.key});
  final MapPlacePickerController mapPlacePickerController =
      Get.put(MapPlacePickerController());
  @override
  Widget build(BuildContext context) {
    final LocationDatas datas = Get.arguments;
    return WillPopScope(
      onWillPop: () {
        Get.back();
        throw Exception();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(2, 1.0548897981643677),
                end: Alignment(-1.0548897981643677, 1.226324439048767),
                colors: [
                  Color.fromRGBO(239, 221, 214, 1),
                  Color.fromRGBO(220, 222, 242, 1),
                  Color.fromRGBO(250, 227, 243, 1),
                  Color.fromRGBO(228, 249, 254, 1)
                ]),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // body: FutureBuilder(
            //     future: mapPlacePickerController.getCurrentLocation(),
            //     builder: (context, snapShot) {
            //       if (snapShot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       return OpenStreetMapSearchAndPick(
            //         buttonWidth: 40.w,
            //         buttonTextStyle:
            //             const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
            //         center:
            //             LatLong(snapShot.data!.latitude, snapShot.data!.longitude),
            //         buttonColor: Color(0xff4956b2),
            //         locationPinIconColor: Color(0xff4956b2),
            //         locationPinText: '',
            //         buttonText: 'Set Location',
            //         onPicked: (pickedData) {
            //           print(pickedData.latLong.latitude);
            //           print(pickedData.latLong.longitude);
            //           print(pickedData.address);
            //           print(pickedData.addressName);
            //           datas.location!.text = pickedData.addressName.toString();
            //           datas.lat!.text = pickedData.latLong.latitude.toString();
            //           datas.long!.text = pickedData.latLong.longitude.toString();
            //           Get.back();
            //         },
            //       );
            //     }),
            body: PlacePicker(
              apiKey: "AIzaSyA6sfxAGWorlekK-rkolU152WkN5mzn76A",
              useCurrentLocation: true,
              initialPosition: LatLng(9.9312328, 76.26730410000005),
              forceSearchOnZoomChanged: true,
              enableMyLocationButton: true,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                  try {
                                                    datas.location!.text =
                                                        selectedPlace
                                                            .formattedAddress!
                                                            .toString();
                                                    datas.lat!.text =
                                                        selectedPlace.geometry!
                                                            .location.lat
                                                            .toString();
                                                    datas.long!.text =
                                                        selectedPlace.geometry!
                                                            .location.lng
                                                            .toString();
                                                    Get.back();
                                                  } catch (e) {
                                                    log(e.toString());
                                                  }
                                                },
                                                // ignore: sort_child_properties_last
                                                child: Text("Select Place"),

                                                minWidth: 200,
                                                height: 45,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
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
          ),
        ),
      ),
    );
  }
}

// import 'package:location_service/location_service.dart';

// class MyMap extends StatefulWidget {
//   const MyMap({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyMap> createState() => _MyMapState();
// }

// class _MyMapState extends State<MyMap> {
//   String locationaddress = "Pick location";
//   double latitude = 9.9312328, longitude = 76.26730410000005;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Center(
//               child: Text(
//             widget.title,
//             style: const TextStyle(color: Colors.green),
//           )),
//           // actions: [
//           //   GestureDetector(
//           //     child: const Icon(
//           //       Icons.delete,
//           //       color: Colors.green,
//           //     ),
//           //     onTap: () {
//           //       print("hiiiiiiiiiiii");
//           //       PickedData? pickedData;
//           //       pickedData!.addressName == "";
//           //     },
//           //   ),
//           //   const SizedBox(
//           //     width: 10,
//           //   )
//           // ],
//         ),
//         body: OpenStreetMapSearchAndPick(
//           buttonTextStyle:
//               const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
//           center: LatLong(latitude, longitude),
//           buttonColor: AppColors.primaryColor,
//           locationPinIconColor: AppColors.primaryColor,
//           locationPinText: '',
//           buttonText: 'Set Location',
//           onPicked: (pickedData) {
//             Provider.of<LocationProvider>(context, listen: false)
//                 .getlocationdata(
//                     pickedData.addressName,
//                     pickedData.latLong.latitude,
//                     pickedData.latLong.longitude,
//                     context);

//             setState(() {
//               locationaddress = pickedData.addressName;
//               latitude = pickedData.latLong.latitude;
//               longitude = pickedData.latLong.longitude;
//             });
//             print(pickedData.latLong.latitude);
//             print(pickedData.latLong.longitude);
//             print(pickedData.address);
//             print(pickedData.addressName);
//           },
//         )
//         // Center(
//         //   child: Container(
//         //     child: InkWell(
//         //       child: Text(locationaddress),
//         //       onTap: () {
//         //         _showModel(context);
//         //       },
//         //     ),
//         //   ),
//         // )
//         );
//   }
// //  void _showModel(BuildContext context) {
// //     showModalBottomSheet(
// //         context: context,
// //         useSafeArea: true,
// //         builder: (context) {
// //           return
// //         });
// //   }
// }
