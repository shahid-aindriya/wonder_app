// To parse this JSON data, do
//
//     final editProductListModel = editProductListModelFromJson(jsonString);

import 'dart:convert';

EditProductListModel editProductListModelFromJson(String str) =>
    EditProductListModel.fromJson(json.decode(str));

String editProductListModelToJson(EditProductListModel data) =>
    json.encode(data.toJson());

class EditProductListModel {
  EditProductData productData;

  EditProductListModel({
    required this.productData,
  });

  factory EditProductListModel.fromJson(Map<String, dynamic> json) =>
      EditProductListModel(
        productData: EditProductData.fromJson(json["product_data"]),
      );

  Map<String, dynamic> toJson() => {
        "product_data": productData.toJson(),
      };
}

class EditProductData {
  int id;
  dynamic name;
  dynamic sku;
  dynamic price;
  dynamic quantity;
  dynamic categoryId;
  dynamic category;
  dynamic subCategoryId;
  dynamic subCategory;
  dynamic featuredImage;
  dynamic discount;
  dynamic discountType;
  bool isFeatured;
  bool active;
  dynamic shopId;
  dynamic vendorId;
  dynamic description;
  dynamic shortDescription;
  dynamic tax;
  dynamic taxType;
  dynamic tags;
  bool returnAvailablility;
  dynamic deliveryCharge;
  dynamic commission;
  String deliveryType;
  dynamic productWeight;
  dynamic noOfReturnDays;
  List<ReasonId> reasonIds;
  List<EditAttribute> attributes;
  List<AllImage> allImages;
  EditProductData(
      {required this.id,
      required this.name,
      required this.sku,
      required this.price,
      required this.quantity,
      required this.categoryId,
      required this.category,
      required this.subCategoryId,
      required this.subCategory,
      required this.featuredImage,
      required this.discount,
      required this.discountType,
      required this.isFeatured,
      required this.active,
      required this.shopId,
      required this.vendorId,
      required this.description,
      required this.shortDescription,
      required this.tax,
      required this.taxType,
      required this.tags,
      required this.returnAvailablility,
      required this.deliveryCharge,
      required this.commission,
      required this.noOfReturnDays,
      required this.productWeight,
      required this.reasonIds,
      required this.attributes,
      required this.allImages,
      required this.deliveryType});

  factory EditProductData.fromJson(Map<String, dynamic> json) =>
      EditProductData(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        quantity: json["quantity"],
        deliveryType: json["delivery_type"],
        categoryId: json["category_id"],
        category: json["category"],
        subCategoryId: json["sub_category_id"],
        subCategory: json["sub_category"],
        featuredImage: json["featured_image"],
        discount: json["discount"],
        discountType: json["discount_type"],
        isFeatured: json["is_featured"],
        active: json["active"],
        shopId: json["shop_id"],
        productWeight: json["product_weight"],
        vendorId: json["vendor_id"],
        description: json["description"],
        shortDescription: json["short_description"],
        tax: json["tax"],
        taxType: json["tax_type"],
        tags: json["tags"],
        returnAvailablility: json["return_availablility"],
        deliveryCharge: json["delivery_charge"],
        commission: json["commission"] ?? "0",
        noOfReturnDays: json["no_of_return_days"],
        reasonIds: List<ReasonId>.from(
            json["reason_ids"].map((x) => ReasonId.fromJson(x))),
        attributes: List<EditAttribute>.from(
            json["attributes"].map((x) => EditAttribute.fromJson(x))),
        allImages: List<AllImage>.from(
            json["all_images"].map((x) => AllImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "category": category,
        "sub_category_id": subCategoryId,
        "sub_category": subCategory,
        "featured_image": featuredImage,
        "discount": discount,
        "discount_type": discountType,
        "is_featured": isFeatured,
        "active": active,
        "shop_id": shopId,
        "vendor_id": vendorId,
        "description": description,
        "short_description": shortDescription,
        "tax": tax,
        "tax_type": taxType,
        "tags": tags,
        "return_availablility": returnAvailablility,
        "delivery_charge": deliveryCharge,
        "commission": commission,
        "no_of_return_days": noOfReturnDays,
        "reason_ids": List<dynamic>.from(reasonIds.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}

class EditAttribute {
  dynamic id;
  dynamic attributeId;
  dynamic attribute;
  dynamic value;
  dynamic image;
  dynamic quantity;
  dynamic fileImage;
  dynamic price;
  dynamic discount;
  EditAttribute(
      {this.id,
      this.attributeId,
      this.attribute,
      this.value,
      this.image,
      this.discount,
      this.price,
      this.quantity,
      this.fileImage});

  factory EditAttribute.fromJson(Map<String, dynamic> json) => EditAttribute(
      id: json["id"],
      attributeId: json["attribute_id"],
      attribute: json["attribute"],
      value: json["value"],
      image: json["image"],
      quantity: json["quantity"],
      price: json['price'],
      discount: json['discount']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "attribute_id": attributeId,
        "attribute": attribute,
        "value": value,
        "file_image": fileImage,
        "image": image,
        "quantity": quantity,
        "discount": discount,
        "price": price
      };
}

class ReasonId {
  dynamic id;
  dynamic title;

  ReasonId({
    required this.id,
    required this.title,
  });

  factory ReasonId.fromJson(Map<String, dynamic> json) => ReasonId(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class AllImage {
  dynamic id;
  dynamic image;

  AllImage({
    this.id,
    required this.image,
  });

  factory AllImage.fromJson(Map<String, dynamic> json) => AllImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
