// To parse this JSON data, do
//
//     final offerDataResponse = offerDataResponseFromJson(jsonString);

import 'dart:convert';

OfferDataResponse offerDataResponseFromJson(String str) =>
    OfferDataResponse.fromJson(json.decode(str));

String offerDataResponseToJson(OfferDataResponse data) =>
    json.encode(data.toJson());

class OfferDataResponse {
  OfferDataResponse({
    required this.offerData,
  });

  List<OfferDatum> offerData;

  factory OfferDataResponse.fromJson(Map<String, dynamic> json) =>
      OfferDataResponse(
        offerData: List<OfferDatum>.from(
            json["offer_data"].map((x) => OfferDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offer_data": List<dynamic>.from(offerData.map((x) => x.toJson())),
      };
}

class OfferDatum {
  OfferDatum({
    required this.id,
    required this.title,
    required this.discount,
    required this.description,
    required this.image,
    required this.status,
  });

  int id;
  String title;
  String discount;
  String description;
  String image;
  String status;

  factory OfferDatum.fromJson(Map<String, dynamic> json) => OfferDatum(
        id: json["id"],
        title: json["title"] ?? "null",
        discount: json["discount"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "discount": discount,
        "description": description,
        "image": image,
        "status": status,
      };
}
