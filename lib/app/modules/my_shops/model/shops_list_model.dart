// To parse this JSON data, do
//
//     final shopsListModel = shopsListModelFromJson(jsonString);

import 'dart:convert';

ShopsListModel shopsListModelFromJson(String str) => ShopsListModel.fromJson(json.decode(str));

String shopsListModelToJson(ShopsListModel data) => json.encode(data.toJson());

class ShopsListModel {
    ShopsListModel({
        required this.shopData,
    });

    List<ShopDatum> shopData;

    factory ShopsListModel.fromJson(Map<String, dynamic> json) => ShopsListModel(
        shopData: List<ShopDatum>.from(json["shop_data"].map((x) => ShopDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "shop_data": List<dynamic>.from(shopData.map((x) => x.toJson())),
    };
}

class ShopDatum {
    ShopDatum({
        required this.id,
        required this.name,
        required this.category,
        required this.gstNumber,
        required this.licenseNumber,
        required this.address,
        required this.location,
        required this.latitude,
        required this.longitude,
        required this.radius,
        required this.isFeatured,
        required this.featuredImage,
        required this.gstImage,
        required this.licenseImage,
        required this.commission,
        required this.status,
    });

    int id;
    String name;
    String category;
    String gstNumber;
    String licenseNumber;
    String address;
    String location;
    String latitude;
    String longitude;
    String radius;
    bool isFeatured;
    String featuredImage;
    String gstImage;
    String licenseImage;
    String commission;
    String status;

    factory ShopDatum.fromJson(Map<String, dynamic> json) => ShopDatum(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        gstNumber: json["gst_number"],
        licenseNumber: json["license_number"],
        address: json["address"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        isFeatured: json["is_featured"],
        featuredImage: json["featured_image"],
        gstImage: json["gst_image"],
        licenseImage: json["license_image"],
        commission: json["commission"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "gst_number": gstNumber,
        "license_number": licenseNumber,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "is_featured": isFeatured,
        "featured_image": featuredImage,
        "gst_image": gstImage,
        "license_image": licenseImage,
        "commission": commission,
        "status": status,
    };
}
