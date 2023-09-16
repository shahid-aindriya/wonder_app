import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../seller_regist/controllers/seller_regist_controller.dart';
import '../model/attribute_model.dart';
import '../model/category_for_add_products.dart';
import '../model/edit_product_details_model.dart';

import '../model/product_list.dart';
import '../model/return_reasons_model.dart';
import '../model/sub_category_for_add_products.dart';

final ProductsController productsController = Get.put(ProductsController());

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
        headers: headers.value);
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
  File? image;
  File? editImageFile;
  pickimage(bool value, addEdit) async {
    final pimage = await ImagePicker().pickImage(
        source: value == true ? ImageSource.camera : ImageSource.gallery);
    if (pimage == null) {
      return;
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

  showPopup(context, addEdit) {
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
                    pickimage(true, addEdit);
                    // Handle the 'Take a photo' option
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    pickimage(false, addEdit);
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

  removeImage() {
    profileImage = "";
    editImage = "";
    update();
  }

  RxList<Category> categoryLists = <Category>[].obs;
  getCategories() async {
    final request = await http.get(
        Uri.parse("${baseUrl.value}get-all-product-categories/"),
        headers: headers.value);
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
        headers: headers.value);
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
        headers: headers.value);
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
        headers: headers.value);
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
    request.fields['attributes'] = jsonEncode(idOfAttribute);
    request.fields['return_availablility'] = returnAvailability.toString();
    request.fields['tags'] = tagsController.text.toString();
    request.fields['tags'] = tagsController.text.toString();
    commission.isEmpty
        ? null
        : request.fields['commission'] = quantityVal.value.toString();
    image != null
        ? request.files
            .add(await http.MultipartFile.fromPath("image", image!.path))
        : null;
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
      idOfAttribute.clear();
      tagsController.clear();
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
        headers: headers.value);
    log(request.body);
    if (request.statusCode == 201) {
      final productListModel = productListModelFromJson(request.body);
      productsLists.assignAll(productListModel.productData);
    }
  }

  removeItem(id) async {
    final body = {"product_id": id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-delete-shop-product/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      await getListOfPrdoucts(invoiceController.selectShopId);
    }
  }

  RxList<EditProductData> editProductsList = <EditProductData>[].obs;
  getProductDetails(id) async {
    final body = {"product_id": id};
    final request = await http.post(
        Uri.parse("${baseUrl.value}vendor-get-shop-product-details/"),
        body: jsonEncode(body),
        headers: headers);
    log(request.body);
    if (request.statusCode == 201) {
      final editProductListModel = editProductListModelFromJson(request.body);
      editProductsList.assign(editProductListModel.productData);
      editControllers.clear();

      if (editProductsList.first.subCategoryId.toString().isNotEmpty) {
        getSubCategory(editProductsList.first.subCategoryId.toString());
      }

      editAttributesList.assignAll(editProductsList.first.attributes);

      listCount.value = editAttributesList.value.length;
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
      quantityVal.value--;
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
      tags}) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl.value}vendor-edit-shop-product/"),
    );
    editLoading.value = true;
    log("attribute:${editAttributesList.value}");
    request.fields["product_id"] = productId;
    request.fields["name"] = name;
    request.fields["shop_id"] = invoiceController.selectShopId;
    request.fields["category_id"] = categoryId;
    request.fields["sub_category_id"] = subCatId;
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
    request.fields["attributes"] = jsonEncode(editAttributesList.value);
    editImageFile != null
        ? request.files.add(
            await http.MultipartFile.fromPath("image", editImageFile!.path))
        : null;
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    log(response.statusCode.toString());
    log(responseBody.toString());
    if (response.statusCode == 201) {
      editLoading.value = false;
      await getListOfPrdoucts(invoiceController.selectShopId);
      productsController.listCount.value = 0;
      productsController.editControllers.clear();
      productsController.subCategoryLists.clear();
      productsController.editAttributesList.clear();
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
    }
  }
}
