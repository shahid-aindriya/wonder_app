import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonder_app/app/modules/add_invoice/models/all_user_model.dart';
import 'package:wonder_app/app/modules/add_invoice/widgets/amount_details.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';
import '../../../data/urls.dart';
import '../../my_shops/model/shops_list_model.dart';

class AddInvoiceController extends GetxController {
  //TODO: Implement AddInvoiceController
  @override
  void onInit() {
    // getAllUsers();
    // getListOfShops();
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
  var shopLists = RxList<ShopDatum>().obs;
  String? selectUserId;
  dynamic selectShopId;
  final TextEditingController searchUserController = TextEditingController();
  final TextEditingController invoiceNumber = TextEditingController();
  final TextEditingController invoiceDAte = TextEditingController();
  final TextEditingController preTaxController = TextEditingController();
  final TextEditingController invoiceAmountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  changeUser({dynamic value, id}) {
    log(selectUserId.toString());
    selectUserId = null;

    selectUserId = value;

    update();
  }

  changeShop({dynamic value, id}) {
    log(value.toString());
    selectShopId = null;

    selectShopId = value;

    update();
  }

  var userLists = RxList<UsersDatum>().obs;
  Future<dynamic> getAllUsers() async {
    try {
      var request = await http.get(
        Uri.parse("${baseUrl.value}get-all-users/"),
        headers: headers,
      );

      log(request.body);
      if (request.statusCode == 201) {
        final allUsersList = allUsersListFromJson(request.body);
        userLists.value.assignAll(allUsersList.usersData);
        searchUserList.assignAll(allUsersList.usersData);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
  }

  String invoiceImg = '';
  File? image;
  dynamic compressedImage;

  pickimage(value) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else {
      image = File(pimage.path);

      final bytes = File(pimage.path).readAsBytesSync();

      compressedImage = testComporessList(bytes);
      invoiceImg = base64Encode(await compressedImage);
      // log(invoiceImg);
    }
    // log(img);
    update();
  }

  RxList<dynamic> amountDetailsList = <dynamic>[].obs;
  var isButtonLoad = false.obs;
  var totalVerified = "".obs;
  invoiceAmountData(shopId, addInvoiceController, customerId) async {
    amountDetailsList.clear();
    isButtonLoad.value = true;
    log(shopId.toString());
    final body = {
      "shop_id": shopId,
      "invoice_amount": invoiceAmountController.text,
    };
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-invoice-amount-data/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.statusCode.toString());
    if (request.statusCode == 201) {
      final data = jsonDecode(request.body);
      amountDetailsList.assign(data);

      isButtonLoad.value = false;
      Get.to(AmountDetails(
        customerId: customerId,
        shopId: shopId,
        addInvoiceController: addInvoiceController,
      ));
    }
  }

  var isLoading = false.obs;
  addInvoice(context, customerid, shopId) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    log(customerid.toString());
    log(userId.toString());
    log(shopId);
    log(invoiceAmountController.text);

    var body = {
      "phone": searchUserController.text,
      "user_id": userId,
      "shop_id": shopId,
      "pre_tax_amount": invoiceAmountController.text,
      "invoice_amount": invoiceAmountController.text,
      "invoice_date": invoiceDAte.text
    };
    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-add-invoice/"),
          headers: headers,
          body: jsonEncode(body));

      log(request.statusCode.toString());
      if (request.statusCode == 201) {
        selectUserId = null;
        invoiceImg = '';
        selectShopId = null;
        invoiceAmountController.clear();
        invoiceDAte.clear();
        invoiceNumber.clear();
        preTaxController.clear();
        remarksController.clear();
        searchUserController.clear();
        invoiceDAte.clear();
        await invoiceController.onPullRefreshInWallet();

        update();
        Get.back();
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
          description: const Text('Invoice added Succesfully'),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
        ).show(context);
      }
    } catch (e) {
      // Get.snackbar("Error", "Something went wrong",
      //     backgroundColor: Colors.red);
    }

    isLoading.value = false;
  }

  Future<dynamic> getListOfShops() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    var body = {"user_id": userId.toString()};

    try {
      var request = await http.post(
          Uri.parse("${baseUrl.value}vendor-all-shop/"),
          headers: headers,
          body: jsonEncode(body));
      // log(request.statusCode.toString());
      if (request.statusCode == 201) {
        final shopsListModel = shopsListModelFromJson(request.body);
        // log(shopsListModel.shopData[0].licenseImage.toString());
        shopLists.value.assignAll(shopsListModel.shopData);

        update();
        return shopsListModel.shopData;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red);
    }
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

  RxList<UsersDatum> searchUserList = <UsersDatum>[].obs;
  getSearchResults(String value) {
    searchUserList.clear();
    for (var index in userLists.value) {
      if (index.phone.toString().toLowerCase().contains(
            value.toLowerCase(),
          )) {
        UsersDatum data = UsersDatum(
            id: index.id,
            name: index.name,
            phone: index.phone,
            image: index.image);
        searchUserList.add(data);
      }
    }
  }

  showPopup(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () {
                    pickimage(true);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false);
                    // Handle the 'Choose from gallery' option
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  dialogPopForAddInvoice(context, customerId, shopId) {
    Get.defaultDialog(
      title: "CONFIRMATION MESSAGE",
      titleStyle: GoogleFonts.roboto(
          color: Color.fromARGB(255, 63, 70, 189),
          fontWeight: FontWeight.bold,
          fontSize: 18),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Are you sure you want to submit the invoice?',
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
        ),
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
              onPressed: isLoading.value == true
                  ? null
                  : () async {
                      await addInvoice(context, customerId, shopId);
                    },
              child: isLoading.value == true
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
                  : Text("Confirm",
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w400)));
        }),
      ),
      cancel: Obx(() {
        return Visibility(
          visible: isLoading.value == true ? false : true,
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
}
