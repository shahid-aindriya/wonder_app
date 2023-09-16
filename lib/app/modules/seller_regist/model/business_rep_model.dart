// To parse this JSON data, do
//
//     final businessRepModel = businessRepModelFromJson(jsonString);

import 'dart:convert';

BusinessRepModel businessRepModelFromJson(String str) =>
    BusinessRepModel.fromJson(json.decode(str));

String businessRepModelToJson(BusinessRepModel data) =>
    json.encode(data.toJson());

class BusinessRepModel {
  List<ListBusinessRep> listBusinessRep;

  BusinessRepModel({
    required this.listBusinessRep,
  });

  factory BusinessRepModel.fromJson(Map<String, dynamic> json) =>
      BusinessRepModel(
        listBusinessRep: List<ListBusinessRep>.from(
            json["list_business_rep"].map((x) => ListBusinessRep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list_business_rep":
            List<dynamic>.from(listBusinessRep.map((x) => x.toJson())),
      };
}

class ListBusinessRep {
  int id;
  String shopName;
  String phone;

  ListBusinessRep({
    required this.id,
    required this.shopName,
    required this.phone,
  });

  factory ListBusinessRep.fromJson(Map<String, dynamic> json) =>
      ListBusinessRep(
        id: json["id"],
        shopName: json["shop_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "phone": phone,
      };
}
