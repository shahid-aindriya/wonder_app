// To parse this JSON data, do
//
//     final invoiceDetailsResponse = invoiceDetailsResponseFromJson(jsonString);

import 'dart:convert';

InvoiceDetailsResponse invoiceDetailsResponseFromJson(String str) =>
    InvoiceDetailsResponse.fromJson(json.decode(str));

String invoiceDetailsResponseToJson(InvoiceDetailsResponse data) =>
    json.encode(data.toJson());

class InvoiceDetailsResponse {
  InvoiceDetailsResponse({
    required this.invoiceData,
    required this.amountData,
  });

  InvoiceData invoiceData;
  AmountData amountData;

  factory InvoiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsResponse(
        invoiceData: InvoiceData.fromJson(json["invoice_data"]),
        amountData: AmountData.fromJson(json["amount_data"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_data": invoiceData.toJson(),
        "amount_data": amountData.toJson(),
      };
}

class AmountData {
  AmountData({
    required this.currentAmount,
    required this.commissionAmount,
    required this.additionalAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
  });

  String currentAmount;
  int commissionAmount;
  int additionalAmount;
  String name;
  String email;
  dynamic razorKey;
  dynamic haveBank;
  dynamic razorSecret;

  factory AmountData.fromJson(Map<String, dynamic> json) => AmountData(
        currentAmount: json["current_amount"],
        commissionAmount: json["commission_amount"],
        additionalAmount: json["additional_amount"],
        name: json["name"],
        email: json["email"],
        razorKey: json["razor_key"] ?? "null",
        razorSecret: json["razor_secret"],
        haveBank: json["have_bank"],
      );

  Map<String, dynamic> toJson() => {
        "current_amount": currentAmount,
        "commission_amount": commissionAmount,
        "additional_amount": additionalAmount,
        "name": name,
        "email": email,
        "razor_key": razorKey,
        "razor_secret": razorSecret,
      };
}

class InvoiceData {
  InvoiceData({
    required this.id,
    required this.customerId,
    required this.userId,
    required this.shopId,
    required this.invoiceImage,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.preTaxAmount,
    required this.invoiceAmount,
    this.remark,
    required this.status,
    required this.myself,
  });

  int id;
  int customerId;
  int userId;
  int shopId;
  String invoiceImage;
  String invoiceNumber;
  DateTime invoiceDate;
  String preTaxAmount;
  String invoiceAmount;
  dynamic remark;
  String status;
  bool myself;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        id: json["id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"],
        invoiceDate: DateTime.parse(json["invoice_date"]),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"],
        status: json["status"],
        myself: json["myself"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "user_id": userId,
        "shop_id": shopId,
        "invoice_image": invoiceImage,
        "invoice_number": invoiceNumber,
        "invoice_date": invoiceDate.toIso8601String(),
        "pre_tax_amount": preTaxAmount,
        "invoice_amount": invoiceAmount,
        "remark": remark,
        "status": status,
        "myself": myself,
      };
}
