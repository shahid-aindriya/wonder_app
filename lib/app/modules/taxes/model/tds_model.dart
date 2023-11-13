// To parse this JSON data, do
//
//     final tdsModel = tdsModelFromJson(jsonString);

import 'dart:convert';

TdsModel tdsModelFromJson(String str) => TdsModel.fromJson(json.decode(str));

String tdsModelToJson(TdsModel data) => json.encode(data.toJson());

class TdsModel {
    List<AllDatum> allData;
    int page;
    int totalPages;

    TdsModel({
        required this.allData,
        required this.page,
        required this.totalPages,
    });

    factory TdsModel.fromJson(Map<String, dynamic> json) => TdsModel(
        allData: List<AllDatum>.from(json["all_data"].map((x) => AllDatum.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "all_data": List<dynamic>.from(allData.map((x) => x.toJson())),
        "page": page,
        "total_pages": totalPages,
    };
}

class AllDatum {
    int id;
    dynamic orderNumber;
    String orderAmount;
    String tdsAmount;
    String amountType;
    DateTime createdAt;

    AllDatum({
        required this.id,
        required this.orderNumber,
        required this.orderAmount,
        required this.tdsAmount,
        required this.amountType,
        required this.createdAt,
    });

    factory AllDatum.fromJson(Map<String, dynamic> json) => AllDatum(
        id: json["id"],
        orderNumber: json["order_number"],
        orderAmount: json["order_amount"],
        tdsAmount: json["tds_amount"],
        amountType: json["amount_type"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "order_amount": orderAmount,
        "tds_amount": tdsAmount,
        "amount_type": amountType,
        "created_at": createdAt.toIso8601String(),
    };
}
