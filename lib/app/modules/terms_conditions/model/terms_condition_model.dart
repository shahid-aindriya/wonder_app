// To parse this JSON data, do
//
//     final termsConditions = termsConditionsFromJson(jsonString);

import 'dart:convert';

TermsConditions termsConditionsFromJson(String str) =>
    TermsConditions.fromJson(json.decode(str));

String termsConditionsToJson(TermsConditions data) =>
    json.encode(data.toJson());

class TermsConditions {
  TermsConditions({
    required this.terms,
  });

  Terms terms;

  factory TermsConditions.fromJson(Map<String, dynamic> json) =>
      TermsConditions(
        terms: Terms.fromJson(json["terms"]),
      );

  Map<String, dynamic> toJson() => {
        "terms": terms.toJson(),
      };
}

class Terms {
  Terms({
    required this.title,
    required this.description,
  });

  String title;
  String description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
