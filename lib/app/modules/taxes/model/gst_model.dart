// To parse this JSON data, do
//
//     final gstModel = gstModelFromJson(jsonString);

import 'dart:convert';

import 'package:wonder_app/app/modules/taxes/model/tds_model.dart';

GstModel gstModelFromJson(String str) => GstModel.fromJson(json.decode(str));

String gstModelToJson(GstModel data) => json.encode(data.toJson());

class GstModel {
    List<AllDatum> allData;
    int page;
    int totalPages;

    GstModel({
        required this.allData,
        required this.page,
        required this.totalPages,
    });

    factory GstModel.fromJson(Map<String, dynamic> json) => GstModel(
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
