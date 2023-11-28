import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../../data/colors.dart';
import '../../seller_regist/controllers/seller_regist_controller.dart';
import '../model/attribute_add_model.dart';
import '../model/attribute_model.dart';
import '../model/category_for_add_products.dart';
import '../model/edit_product_details_model.dart';

import '../model/product_list.dart';
import '../model/return_reasons_model.dart';
import '../model/sub_category_for_add_products.dart';

class ProductsController extends GetxController {
  //TODO: Implement ProductsController
  final SellerRegistController sellerRegistController =
      Get.put(SellerRegistController());
  final count = 0.obs;
  @override
  void onInit() {
    controllers.add(TextEditingController());
    // TODO: implement onInit
    super.onInit();
  }

  void increment() => count.value++;

  RxInt quantityVal = (-1).obs;
  RxString commission = ''.obs;
  selectQuantity(value) {
    if (value == false &&
        quantityVal.value > 1 &&
        quantityVal.value > int.tryParse(commission.value.toString())!) {
      quantityVal.value--;
    } else if (value == true) {
      quantityVal.value++;
    }
  }

  calculateCommission(id) {
    for (var element in categoryLists) {
      if (id == element.id) {
        commission.value = element.commission.toString();

        quantityVal.value = int.tryParse(element.commission.toString())!;
      }
    }
  }

  var switchValue = false.obs;
  switchChange(value, id) async {
    final body = {"product_id": id, "active": value == true ? "true" : "false"};
    final request = await http.post(
        Uri.parse(
          "${baseUrl.value}vendor-change-product-status/",
        ),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      await getListOfPrdoucts(invoiceController.selectShopId);
    }
  }

  List<String> unitList = ['Number', 'Digit'];
  List<String> availabilityList = ['Available', 'Not-Available'];
  List<String> typeList = ['% Percentage', 'Amount'];
  List<String> categoryList = ['Detergents', 'Soaps'];
  List<String> deliveryTypeList = ['Vendor On Delivery', 'Wonder on Delivery'];
  List<String> sortList = ['Availability', 'Relevence'];
  dynamic selectedValue;
  dynamic sortValue;

  dynamic compressedImage;
  String profileImage = '';
  String editImage = "";
  String attributeImage = "";
  File? image;
  File? editImageFile;
  File? attributeFileImage;
  pickimage(bool value, addEdit, {dynamic attriubte}) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
    } else if (attriubte != null) {
      attributeFileImage = File(pimage.path);
      final ims = await sellerRegistController.cropsImage(pimage.path);
      if (ims != null) {
        final bytes = File(ims.path).readAsBytesSync();
        compressedImage = testComporessList(bytes);
        attributeImage = base64Encode(await compressedImage);
        update();
        return;
      } else {
        return null;
      }
    } else if (addEdit == "Add") {
      image = File(pimage.path);
      final ims = await sellerRegistController.cropsImage(pimage.path);
      if (ims != null) {
        final bytes = File(ims.path).readAsBytesSync();
        compressedImage = testComporessList(bytes);
        profileImage = base64Encode(await compressedImage);
        update();
        return;
      } else {
        return null;
      }
    } else {
      editImageFile = File(pimage.path);
      final ims = await sellerRegistController.cropsImage(pimage.path);
      if (ims != null) {
        final bytes = File(ims.path).readAsBytesSync();
        compressedImage = testComporessList(bytes);
        editImage = base64Encode(await compressedImage);
        update();
        return;
      } else {
        return null;
      }
    }
    // log(img);
  }

  testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 600,
      minWidth: 400,
      quality: 70,
      format: CompressFormat.jpeg,
      rotate: 0,
    );
    log(list.length.toString());
    log(result.length.toString());
    return result.toList();
  }

  RxList<File> multiEditImages = <File>[].obs;
  RxList<File> multiImages = <File>[].obs;
  selectMultipleImages(value) async {
    try {
      List<XFile> pimage = await ImagePicker()
          .pickMultiImage(imageQuality: 80, maxHeight: 1080, maxWidth: 1920);
      if (pimage.isEmpty) {
        return;
      } else {
        if (pimage.isNotEmpty && value == true) {
          for (var i = 0; i < pimage.length; i++) {
            File imageFile = File(pimage[i].path);
            File compressedImage = await compressImage(imageFile);
            multiImages.add(compressedImage);
          }
        } else {
          for (var i = 0; i < pimage.length; i++) {
            File imageFile = File(pimage[i].path);
            File compressedImage = await compressImage(imageFile);
            final AllImage allImage = AllImage(image: compressedImage);
            imageList.add(allImage);
            multiEditImages.add(compressedImage);
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  compressImage(File imageFile) async {
    // ImageProperties properties =
    //     await FlutterNativeImage.getImageProperties(imageFile.path);
    File compressedFile2 = await FlutterNativeImage.compressImage(
        imageFile.path,
        quality: 80,
        targetWidth: 600,
        targetHeight: 700);
    File compressedFile = await FlutterNativeImage.compressImage(
        compressedFile2.path,
        quality: 100,
        percentage: 70);
    // File compressedFile = await FlutterNativeImage.compressImage(imageFile.path,
    //     quality: 100, percentage: 100);
    return compressedFile;
  }

  showPopup(context, addEdit, {dynamic attriubte}) {
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
                    pickimage(true, addEdit, attriubte: attriubte);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false, addEdit, attriubte: attriubte);
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

  removeImage({value}) {
    if (value == true) {
      attributeImage = "";
      update();
      return;
    }
    profileImage = "";
    editImage = "";

    update();
  }

  RxList<Category> categoryLists = <Category>[].obs;
  getCategories() async {
    final request = await http.get(
        Uri.parse("${baseUrl.value}get-all-product-categories/"),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final categoryForAddingProducts =
          categoryForAddingProductsFromJson(request.body);
      categoryLists.assignAll(categoryForAddingProducts.categories);
    }
  }

  RxList<Category> subCategoryLists = <Category>[].obs;
  getSubCategory(id) async {
    final body = {"category_id": id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}get-all-product-sub-categories/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      subCatId = null;
      final subCategoryForAddingProducts =
          subCategoryForAddingProductsFromJson(request.body);
      subCategoryLists.assignAll(subCategoryForAddingProducts.categories);
      subCatId = subCategoryLists.isNotEmpty ? subCategoryLists.first.id : null;
      update();
    }
  }

  RxList<Attribute> attributeLists = <Attribute>[].obs;
  getAllAttribute() async {
    final request = await http.get(
        Uri.parse("${baseUrl.value}get-all-attributes/"),
        headers: headers);
    // log(request.body);
    if (request.statusCode == 201) {
      final attributeModel = attributeModelFromJson(request.body);
      attributeLists.assignAll(attributeModel.attributes);
    }
  }

  final idOfAttribute = [];
  void addIdAndValue(String id, String value) {
    bool idExists = idOfAttribute.any((map) => map["id"] == id);

    if (!idExists) {
      idOfAttribute.add({"id": id, "value": value});
      log("id :${idOfAttribute.toString()}");
      update();
    } else {
      // Update the value if the id already exists
      int existingIndex = idOfAttribute.indexWhere((map) => map["id"] == id);
      idOfAttribute[existingIndex]["value"] = value;
      log("id :${idOfAttribute.toString()}");
      update();
    }
  }

  // ... Other methods ...

  getIdOfAttributes(id, index) {
    log(index.toString());
    bool idExists = idOfAttribute.any((map) => map["id"] == id.toString());

    if (!idExists) {
      idOfAttribute.insert(index, {"id": id.toString(), "value": ""});
      log("id :${idOfAttribute.toString()}");
      update();
    }
  }

  // void addIdOfAttribute(String id, String value) {
  //   bool idExists = idOfAttribute.any((map) => map["id"] == id.toString());

  //   if (!idExists) {
  //     idOfAttribute.add({"id": id, "value": value});
  //     log("id :${idOfAttribute.toString()}");
  //     update();
  //   }

  //   log(idOfAttribute.toString());
  // }

  // RxList<ReturnReason> returnReasonLists = <ReturnReason>[].obs;
  // final List<MultiSelectItem<int>> items = [
  //   MultiSelectItem(1, 'Option 1'),
  //   MultiSelectItem(2, 'Option 2'),
  //   MultiSelectItem(3, 'Option 3'),
  //   // Add more items as needed
  // ];
  late List<MultiSelectItem<int>> returnReasons = [];
  final List<dynamic> idOfREturnLists = [];
  getAllReturn() async {
    final request = await http.get(
        Uri.parse("${baseUrl.value}get-all-return-reasons/"),
        headers: headers);
    // log(request.body);
    if (request.statusCode == 201) {
      final returnReasonsModel = returnReasonsModelFromJson(request.body);
      returnReasons = returnReasonsModel.returnReasons
          .map((reason) => MultiSelectItem(reason.id, reason.title))
          .toList();
      update();
      log(returnReasons.toString());
    }
  }

  getIdOfReturns(List<int> id) {
    idOfREturnLists.assignAll(id);
    log("id :${idOfREturnLists.toString()}");
    update();
  }

  RxInt attriCount = 1.obs;
  final controllers = <TextEditingController>[].obs;
  final TextEditingController valueAttributeController =
      TextEditingController();
  final TextEditingController quantityAttributeController =
      TextEditingController();
  final TextEditingController priceAttributeController =
      TextEditingController();
  final TextEditingController discountAttributeController =
      TextEditingController();

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController skuEditingController = TextEditingController();
  final TextEditingController quantityEditingController =
      TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final TextEditingController taxEditingController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController deliveryChargeController =
      TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  dynamic taxType;
  dynamic discType;
  dynamic catId;
  dynamic subCatId;
  dynamic returnAvailability;
  dynamic deliveryTypeId;

  var addLoading = false.obs;
  addProducts(context) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl.value}vendor-add-shop-product/"),
    );
    addLoading.value = true;
    request.fields['name'] = nameEditingController.text.toString();
    request.fields['shop_id'] = invoiceController.selectShopId.toString();
    request.fields['category_id'] = catId.toString();
    subCatId == null
        ? null
        : request.fields['sub_category_id'] = subCatId.toString();
    request.fields['price'] = priceEditingController.text.toString();
    request.fields['quantity'] = quantityEditingController.text.toString();
    request.fields['short_description'] =
        descriptionEditingController.text.toString();
    // request.fields['tax'] = taxEditingController.text.toString();
    request.fields['discount'] = discountController.text.toString();
    request.fields['discount_type'] = discType.toString();
    // request.fields['tax_type'] = taxType.toString();
    request.fields['return_reason_ids'] = idOfREturnLists.join(",");
    request.fields['attributes'] = jsonEncode(attributeAddList.toJson());
    request.fields['return_availablility'] = returnAvailability.toString();
    request.fields['tags'] = tagsController.text.toString();
    request.fields['delivery_type'] = deliveryTypeId.toString();
    request.fields['delivery_charge'] =
        deliveryChargeController.text.toString();

    request.fields['product_weight'] = netWeightController.text.toString();
    commission.isEmpty
        ? null
        : request.fields['commission'] = quantityVal.value.toString();
    // request.files.add(await http.MultipartFile.fromPath("image", image!.path));

    for (int i = 0; i < multiImages.length; i++) {
      File image = multiImages[i];
      request.files.add(
        await http.MultipartFile.fromPath(
          'image[$i]',
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    log(response.statusCode.toString());
    log(responseBody.toString());
    if (response.statusCode == 201) {
      nameEditingController.clear();
      catId = null;
      subCatId = null;
      priceEditingController.clear();
      quantityEditingController.clear();
      descriptionEditingController.clear();
      taxEditingController.clear();
      discountController.clear();
      idOfREturnLists.clear();
      attributeAddList.clear();
      idOfAttribute.clear();
      tagsController.clear();
      deliveryChargeController.clear();
      netWeightController.clear();
      multiImages.clear();
      profileImage = "";
      update();
      await getListOfPrdoucts(invoiceController.selectShopId);
      addLoading.value = false;
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
        description: const Text('Product Added Successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    } else {
      addLoading.value = false;
      MotionToast.error(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Error ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text('Something went wrong'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
  }

  RxList<ProductDatum> productsLists = <ProductDatum>[].obs;

  getListOfPrdoucts(id) async {
    final body = {"shop_id": id};
    final request = await http.post(
        Uri.parse(
          "${baseUrl.value}vendor-list-shop-product/",
        ),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final productListModel = productListModelFromJson(request.body);
      productsLists.assignAll(productListModel.productData);
    }
  }

  removeItem(id, context) async {
    final body = {"product_id": id};
    isRemoveLoading.value = true;
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-shop-product/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      await getListOfPrdoucts(invoiceController.selectShopId);
      isRemoveLoading.value = false;
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
        description: const Text('Removed Successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    } else {
      isRemoveLoading.value = false;
      Get.back();
      MotionToast.error(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Error ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text('Something Went Wrong'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
  }

  RxList<EditProductData> editProductsList = <EditProductData>[].obs;
  RxList<AllImage> imageList = <AllImage>[].obs;
  getProductDetails(id) async {
    final body = {"product_id": id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-get-shop-product-details/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      editAttributesList.clear();
      final editProductListModel = editProductListModelFromJson(request.body);
      editProductsList.assign(editProductListModel.productData);
      editControllers.clear();
      imageList.assignAll(editProductListModel.productData.allImages);
      if (editProductsList.first.subCategoryId != null) {
        getSubCategory(editProductsList.first.categoryId);
      }

      editAttributesList.assignAll(editProductsList.first.attributes);

      listCount.value = editAttributesList.length;
      editQuantityVal.value =
          int.tryParse(editProductListModel.productData.commission.toString())!;
      editCommission.value =
          editProductListModel.productData.commission.toString();

      // for (var itemData in editProductsList.first.attributes) {
      //   var attributeId = itemData.attributeId;
      //   var value = itemData.value;

      //   var map = {
      //     'id': attributeId.toString(),
      //     'value': value.toString(),
      //   };

      //   editIdOfAttributes.add(map);
      // }
      // log(editIdOfAttributes.toString());
    }
  }

  final RxList<TextEditingController> editControllers =
      <TextEditingController>[].obs;

  List<dynamic> editIdOfReturn = [];

  RxInt listCount = 0.obs;
  RxList<EditAttribute> editAttributesList = <EditAttribute>[].obs;
  void getEditIdOfReturns(List<dynamic> ids) {
    editIdOfReturn = ids;

    log("id :${editIdOfReturn.toString()}");
    update(); // Trigger UI update
  }

  getEditIdOfAttributes(id, index) {
    log(index.toString());
    if (index >= 0 && index < editAttributesList.length) {
      editAttributesList[index] = EditAttribute(attributeId: id);
    } else {
      log("Invalid index");
    }
    log(editAttributesList.toString());
    // log(index.toString());
    // bool idExists = editIdOfAttributes.any((map) => map["id"] == id.toString());
    // log("id :${editIdOfAttributes.toString()}");
    // if (!idExists) {
    //   editIdOfAttributes.insert(index, {"id": id.toString(), "value": ""});
    //   log("id :${editIdOfAttributes.toString()}");
    //   update();
    // }
  }

  void addEditIdAndValue(String id, String value, int index) {
    bool idExists =
        editAttributesList.any((map) => map.attributeId == int.tryParse(id));

    if (!idExists) {
      editAttributesList.insert(
          index, EditAttribute(attributeId: int.tryParse(id), value: value));
    } else {
      int existingIndex = editAttributesList
          .indexWhere((map) => map.attributeId == int.tryParse(id));
      editAttributesList[existingIndex].value = value;
    }
    log(editAttributesList.toString());
    update(); // Assuming this triggers a rebuild of the UI using GetX
  }

  RxInt editQuantityVal = (-1).obs;
  RxString editCommission = ''.obs;
  editSelectQuantity(value) {
    if (value == false &&
        editQuantityVal.value > 1 &&
        editQuantityVal.value >
            int.tryParse(editCommission.value.toString())!) {
      editQuantityVal.value--;
    } else if (value == true) {
      editQuantityVal.value++;
    }
  }

  editCalculateCommission(id) {
    for (var element in categoryLists) {
      if (id == element.id) {
        editCommission.value = element.commission.toString();

        editQuantityVal.value = int.tryParse(element.commission.toString())!;
      }
    }
  }

  var editLoading = false.obs;
  editProductDetails(
      {productId,
      name,
      price,
      categoryId,
      subCatId,
      quantity,
      shortDescription,
      // tax,
      // taxType,
      discount,
      discType,
      context,
      tags,
      deliveryType,
      deliveryCharge,
      netWeight}) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl.value}vendor-edit-shop-product/"),
    );
    editLoading.value = true;
    // for (var element in editAttributesList) {
    //   log(element.attribute.toString());
    //   log(element.attributeId.toString());
    //   log(element.fileImage.toString());
    //   log(element.image.toString());
    //   log(element.value.toString());
    //   log(element.quantity.toString());
    // }
    request.fields["product_id"] = productId;
    request.fields["name"] = name;
    request.fields["shop_id"] = invoiceController.selectShopId;
    request.fields["category_id"] = categoryId;
    subCatId == null ? null : request.fields["sub_category_id"] = subCatId;
    request.fields["price"] = price;
    request.fields["quantity"] = quantity;
    request.fields["short_description"] = shortDescription;
    // request.fields["tax"] = tax;
    // request.fields["tax_type"] = taxType;
    request.fields["discount"] = discount;
    request.fields["discount_type"] = discType;
    request.fields["tags"] = tags;
    editCommission.value.isEmpty
        ? null
        : request.fields['commission'] = editQuantityVal.value.toString();
    request.fields["return_reason_ids"] = editIdOfReturn.join(",");
    request.fields['delivery_type'] = deliveryType;
    request.fields['delivery_charge'] = deliveryCharge;
    request.fields['product_weight'] = netWeight;
    request.fields["attributes"] = jsonEncode(editAttributesList.toJson());
    for (int i = 0; i < imageList.length; i++) {
      if (imageList[i].id == null) {
        File image = imageList[i].image;
        request.files.add(
          await http.MultipartFile.fromPath(
            'image[$i]',
            image.path,
            filename: image.path.split('/').last,
          ),
        );
      }
    }
    // editImageFile != null
    //     ? request.files.add(
    //         await http.MultipartFile.fromPath("image", editImageFile!.path))
    //     : null;
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    log(response.statusCode.toString());
    log(responseBody.toString());
    if (response.statusCode == 201) {
      editLoading.value = false;
      await getListOfPrdoucts(invoiceController.selectShopId);
      listCount.value = 0;
      editControllers.clear();
      subCategoryLists.clear();
      editAttributesList.clear();

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
        description: const Text('Product updated Successfully'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    } else {
      editLoading.value = false;
      Get.back();
      MotionToast.error(
        dismissable: true,
        enableAnimation: false,
        position: MotionToastPosition.top,
        title: const Text(
          'Error ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        description: const Text('Something went wrong'),
        animationCurve: Curves.bounceIn,
        borderRadius: 0,
        animationDuration: const Duration(milliseconds: 1000),
      ).show(context);
    }
    editLoading.value = false;
  }

  deleteAttribute(id, productId) async {
    log(productId.toString());
    final body = {"attribute_id": id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-product-attribute/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      await getProductDetails(productId);
      Get.back();
    }
  }

  final isRemoveLoading = false.obs;
  dialogPopForAddInvoice(context, id) {
    Get.defaultDialog(
      title: "CONFIRMATION MESSAGE",
      titleStyle: GoogleFonts.roboto(
          color: Color.fromARGB(255, 63, 70, 189),
          fontWeight: FontWeight.bold,
          fontSize: 18),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Are you sure you want to delete?',
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
              onPressed: isRemoveLoading.value == true
                  ? null
                  : () async {
                      await removeItem(id, context);
                    },
              child: isRemoveLoading.value == true
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
          visible: isRemoveLoading.value == true ? false : true,
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

  RxList<AttriubuteAddModel> attributeAddList = <AttriubuteAddModel>[].obs;
  dynamic attributeId;
  dynamic imageId = 1;
  // RxList<File> attributeImageList = <File>[].obs;
  void addAttributeToList() {
    log(attributeFileImage!.path);
    final newProduct = AttriubuteAddModel(
        id: attributeId,
        value: valueAttributeController.text,
        quantity: quantityAttributeController.text,
        image: attributeImage,
        discount: discountAttributeController.text,
        price: priceAttributeController.text
        // imageId: imageId,
        );
    // attributeImageList.add(attributeFileImage!);
    attributeAddList.add(newProduct);
    quantityEditingController.clear();
    int count = 0;
    for (var element in attributeAddList) {
      count = count + int.tryParse(element.quantity.toString())!;
      log(count.toString());
    }
    quantityEditingController.text = count.toString();
    imageId++;
    valueAttributeController.clear();
    quantityAttributeController.clear();
    priceAttributeController.clear();
    discountAttributeController.clear();
    attributeImage = "";
    update();
  }

  dynamic editAttributeId;
  final TextEditingController editValueAttributeController =
      TextEditingController();
  final TextEditingController editQuantityAttributeController =
      TextEditingController();
  final TextEditingController editQuantityEditingController =
      TextEditingController();
  final TextEditingController editAttributeDiscountEditingController =
      TextEditingController();
  final TextEditingController editAttributePriceEditingController =
      TextEditingController();
  void editAttributeToList() {
    log(attributeFileImage!.path);
    final newProduct = EditAttribute(
        attributeId: editAttributeId,
        value: editValueAttributeController.text,
        quantity: editQuantityAttributeController.text,
        fileImage: attributeImage,
        discount: editAttributeDiscountEditingController.text,
        price: editAttributePriceEditingController.text);

    editAttributesList.add(newProduct);
    int count = 0;
    editQuantityEditingController.clear();
    for (var element in editAttributesList) {
      count = count + int.tryParse(element.quantity.toString())!;
      log(count.toString());
    }
    editQuantityEditingController.text = count.toString();
    editValueAttributeController.clear();

    editQuantityAttributeController.clear();
    editAttributeDiscountEditingController.clear();
    editAttributePriceEditingController.clear();
    attributeImage = "";

    update();
  }

  removeAttributeFromList(index, quantity) {
    attributeAddList.removeAt(index);
    final quant = int.tryParse(editQuantityEditingController.text);
    num realCount = quant! - int.tryParse(quantity)!;
    log(realCount.toString());
    editQuantityEditingController.text = realCount.toString();
  }

  removeEditAttributeFromList(index, quantity) {
    editAttributesList.removeAt(index);
    final quant = int.tryParse(editQuantityEditingController.text);
    num realCount = quant! - int.tryParse(quantity)!;
    log(realCount.toString());
    editQuantityEditingController.text = realCount.toString();
    Get.back();
  }

  deleteImageFromList(imageId, id, context, index) async {
    if (imageList.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Atleast one image required',
              style: GoogleFonts.roboto(
                  fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      );
      return;
    }
    if (imageList[index].id == null) {
      imageList.removeAt(index);

      return;
    }

    final body = {"image_id": imageId};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-shop-product-image/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 200) {
      await getProductDetails(id);
    }
    await getProductDetails(id);
  }

  dynamic attriId;
  final TextEditingController valueAttController = TextEditingController();
  final TextEditingController discountAttController = TextEditingController();
  final TextEditingController priceAttController = TextEditingController();
  final TextEditingController quantityAttController = TextEditingController();
  var isAttLoading = false.obs;

  attributeEditDialogBox(attribId,
      {context,
      attributeId,
      value,
      discount,
      price,
      quantity,
      id,
      productId,
      index}) {
    attriId = attributeId;
    valueAttController.text = value;
    discountAttController.text = discount;
    priceAttController.text = price;
    quantityAttController.text = quantity;

    Alert(
      context: context,
      title: "Edit Attribute",
      style: AlertStyle(
          overlayColor: Color.fromARGB(120, 0, 0, 0),
          titleStyle: GoogleFonts.jost(
              color: textGradientBlue, fontWeight: FontWeight.w500)),
      content: Column(
        children: <Widget>[
          Form(
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: attriId,
                  decoration: InputDecoration(labelText: "Select Attribute"),
                  items: attributeLists.map((data) {
                    return DropdownMenuItem(
                        value: data.id,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            data.title,
                            overflow: TextOverflow.visible,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    // productsController
                    //     .getIdOfAttributes(
                    //         value, index);
                    log(value.toString());
                    attriId = value;
                  },
                ),
                TextFormField(
                  controller: valueAttController,
                  decoration: InputDecoration(
                    labelText: 'Enter Value',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceAttController,
                  decoration: InputDecoration(
                    labelText: 'Enter Price',
                  ),
                ),
                TextFormField(
                  controller: quantityAttController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter quantity',
                  ),
                ),
                TextFormField(
                  controller: discountAttController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter discount',
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
          onPressed: () {
            editAttr(id: id, attribute: attribId);
          },
          child: Obx(() {
            return isAttLoading.value == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
          }),
        ),
        DialogButton(
          gradient: LinearGradient(
            begin: Alignment(-0.934, -1),
            end: Alignment(1.125, 1.333),
            colors: <Color>[
              Color.fromARGB(228, 189, 63, 63),
              Color.fromARGB(228, 232, 87, 65)
            ],
            stops: <double>[0, 1],
          ),
          radius: BorderRadius.circular(10),
          onPressed: () {
            log(attribId.toString());
            attribId != null
                ? deleteAttribute(attribId, productId)
                : removeEditAttributeFromList(index, quantity);
          },
          child: Obx(() {
            return isAttLoading.value == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    "Delete",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
          }),
        ),
      ],
    ).show();
  }

  editAttr({id, attribute}) async {
    isAttLoading.value = true;
    final body = {
      "attribute_id": attribute,
      "value": valueAttController.text,
      "quantity": quantityAttController.text,
      "price": priceAttController.text,
      "discount": discountAttController.text,
    };
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-edit-product-attribute/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.statusCode.toString());
    if (request.statusCode == 201) {
      await getProductDetails(id);

      isAttLoading.value = false;
      Get.back();
    }
    isAttLoading.value = false;
  }
}
