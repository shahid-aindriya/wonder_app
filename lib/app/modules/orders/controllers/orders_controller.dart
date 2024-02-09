import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../model/order_details_model.dart';
import '../model/order_model.dart';

final OrdersController ordersController = Get.put(OrdersController());

class OrdersController extends GetxController {
  //TODO: Implement OrdersController

  final count = 0.obs;

  void increment() => count.value++;
  RxInt selectedCard = (-1).obs;
  selectCard(value) {
    selectedCard.value = value;
  }

  RxList<OrderDatum> ordersList = <OrderDatum>[].obs;
  getListOfOrders(id) async {
    final body = {'shop_id': id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-list-shop-order/"),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body.toString());
    if (request.statusCode == 201) {
      final orderModel = orderModelFromJson(request.body);
      ordersList.assignAll(orderModel.orderData);
    }
  }

  dynamic selectedValue;
  List<String> returnReasonsList = [
    'Pending',
    'Received',
    'Confirmed',
    'Ready to pickup',
    'On the way',
    'Delivered',
    'Completed'
  ];

  List<String> returnReasonsList2 = [
    'Pending',
    'Received',
    'Confirmed',
    'Ready to pickup',
    'On the way',
    'Delivered',
  ];
  final isreturnLoading = false.obs;
  showReturnPopUp(context, {required orderId, status}) {
    Get.defaultDialog(
      title: "Change Order Status",
      titleStyle: GoogleFonts.roboto(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 18),
      content: DropdownButtonFormField(
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
            hintStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: Color.fromARGB(255, 63, 70, 189)),
            hintText: "Select",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 0, color: Color.fromARGB(255, 255, 255, 255))),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 0, color: Color.fromARGB(255, 255, 255, 255)),
                borderRadius: BorderRadius.circular(10)),
            fillColor: Color.fromARGB(255, 255, 255, 255),
            focusColor: Color.fromARGB(255, 255, 255, 255)),
        value: selectedValue,
        onChanged: (value) async {
          selectedValue = value;
        },
        items: status == true
            ? returnReasonsList.map((data) {
                return DropdownMenuItem(
                    value: data,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        data,
                        overflow: TextOverflow.visible,
                      ),
                    ));
              }).toList()
            : returnReasonsList2.map((data) {
                return DropdownMenuItem(
                    value: data,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        data,
                        overflow: TextOverflow.visible,
                      ),
                    ));
              }).toList(),
      ),
      contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      confirm: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment(0.8374384045600891, 0.11822659522294998),
              end: Alignment(-0.11822660267353058, 0.10431758314371109),
              colors: [
                Color.fromRGBO(63, 70, 189, 1),
                Color.fromRGBO(65, 125, 232, 1)
              ]),
        ),
        child: Obx(() {
          return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0)),
              onPressed: isreturnLoading.value == true
                  ? null
                  : () {
                      changeProductStatus(context,
                          orderId: orderId, status: selectedValue);
                    },
              child: isreturnLoading.value == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Processing",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                      ],
                    )
                  : Text("Submit",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)));
        }),
      ),
      cancel: Obx(() {
        return Visibility(
          visible: isreturnLoading.value ? false : true,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 236, 236, 236)),
            child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(100, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 81, 90, 197),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          ),
        );
      }),
    );
  }

  changeProductStatus(context, {orderId, status}) async {
    final body = {"order_id": orderId, "status": status};

    isreturnLoading.value = true;
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-shop-order-status-change/"),
        body: jsonEncode(body),
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      await getListOfOrders(invoiceController.selectShopId);
      await orderDetails(orderId);
      isreturnLoading.value = false;
      Get.back();
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
        description: const Text('Status updated successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    } else {
      isreturnLoading.value = false;
      Get.back();
      MotionToast.error(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Failure ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text("Status couldn't be updated"),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
  }

  RxList<OrderData> orderDetailsList = <OrderData>[].obs;
  orderDetails(orderId) async {
    final body = {'order_id': orderId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-shop-order-details/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final orderDetailsModel = orderDetailsModelFromJson(request.body);
      orderDetailsList.assign(orderDetailsModel.orderData);
    }
  }

  final TextEditingController trackIdController = TextEditingController();
  final TextEditingController trackUrlController = TextEditingController();

  showTrackingIdPopUp(
    context, {
    required orderId,
  }) {
    Alert(
      context: context,
      content: Column(
        children: <Widget>[
          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Tracking ID",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: trackIdController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 240, 240, 240))),
                    filled: true,
                    fillColor: Color.fromARGB(255, 202, 201, 201),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 240, 240, 240))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Tracking URL",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: trackUrlController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 240, 240, 240))),
                    filled: true,
                    fillColor: Color.fromARGB(255, 202, 201, 201),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: Color.fromARGB(255, 240, 240, 240))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment(-0.934, -1),
            end: Alignment(1.125, 1.333),
            colors: <Color>[Color(0xe53f46bd), Color(0xe5417de8)],
            stops: <double>[0, 1],
          ),
          radius: BorderRadius.circular(10),
          onPressed: isreturnLoading.value
              ? null
              : () {
                  updateTrackId(orderId);
                },
          child: Obx(() {
            return isreturnLoading.value
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
          }),
        ),
      ],
    ).show();
  }

  updateTrackId(orderId) async {
    isreturnLoading.value = true;
    final body = {
      'order_id': orderId,
      "tracking_number": trackIdController.text,
      "tracking_url": trackUrlController.text,
    };
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-edit-order-tracking-data/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      isreturnLoading.value = false;
      Get.back();
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
        description: const Text('updated successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(Get.context!);
    } else {
      isreturnLoading.value = false;
      Get.back();
      MotionToast.error(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Failure ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text("Status couldn't be updated"),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(Get.context!);
    }
    isreturnLoading.value = false;
  }
}
