// To parse this JSON data, do
//
//     final offerDataResponse = offerDataResponseFromJson(jsonString);

import 'dart:convert';

OfferDataResponse offerDataResponseFromJson(String str) =>
    OfferDataResponse.fromJson(json.decode(str));

String offerDataResponseToJson(OfferDataResponse data) =>
    json.encode(data.toJson());

class OfferDataResponse {
  List<OfferDatum> offerData;

  OfferDataResponse({
    required this.offerData,
  });

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
  int id;
  dynamic title;
  dynamic discount;
  dynamic description;
  dynamic image;
  dynamic status;
  dynamic video;
  dynamic link;
  dynamic discountAmount;

  OfferDatum({
    required this.id,
    required this.title,
    required this.discount,
    required this.description,
    required this.image,
    required this.status,
    required this.video,
    required this.discountAmount,
    required this.link,
  });

  factory OfferDatum.fromJson(Map<String, dynamic> json) => OfferDatum(
      id: json["id"],
      title: json["title"],
      discount: json["discount"],
      description: json["description"],
      image: json["image"],
      status: json["status"],
      video: json["video"],
      link: json["link"],
      discountAmount: json["discount_amount"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "discount": discount,
        "description": description,
        "image": image,
        "status": status,
        "video": video,
        "link": link,
      };
}
