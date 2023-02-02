// To parse this JSON data, do
//
//     final invoiceData = invoiceDataFromJson(jsonString);

import 'dart:convert';

InvoiceData invoiceDataFromJson(String str) =>
    InvoiceData.fromJson(json.decode(str));

String invoiceDataToJson(InvoiceData data) => json.encode(data.toJson());

class InvoiceData {
  InvoiceData({
    required this.invoiceData,
  });

  List<InvoiceDatum> invoiceData;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        invoiceData: List<InvoiceDatum>.from(
            json["invoice_data"].map((x) => InvoiceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoice_data": List<dynamic>.from(invoiceData.map((x) => x.toJson())),
      };
}

class InvoiceDatum {
  InvoiceDatum({
    required this.id,
    this.customerId,
    this.customerName,
    this.phone,
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
  dynamic customerId;
  int userId;
  int shopId;
  String? customerName;
  String? phone;
  String invoiceImage;
  String invoiceNumber;
  DateTime invoiceDate;
  String preTaxAmount;
  String invoiceAmount;
  dynamic remark;
  String status;
  bool myself;

  factory InvoiceDatum.fromJson(Map<String, dynamic> json) => InvoiceDatum(
        id: json["id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        customerName: json["customer_name"] ?? "null",
        phone: json["phone"] ?? "null",
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
        "customer_name": customerName,
        "phone": phone,
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
