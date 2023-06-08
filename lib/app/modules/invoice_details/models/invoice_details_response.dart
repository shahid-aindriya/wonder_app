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
    required this.totalAmount,
    required this.razorSecret,
    required this.haveBank,
  });

  dynamic currentAmount;
  dynamic commissionAmount;
  dynamic additionalAmount;
  dynamic totalAmount;
  String name;
  String email;
  dynamic razorKey;
  dynamic haveBank;
  dynamic razorSecret;

  factory AmountData.fromJson(Map<String, dynamic> json) => AmountData(
        currentAmount: json["current_amount"],
        commissionAmount: json["commission_amount"],
        totalAmount: json["total_amount"],
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
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.vendorName,
    required this.vendorPhone,
    required this.shopId,
    required this.shopName,
    required this.invoiceImage,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.preTaxAmount,
    required this.invoiceAmount,
    required this.remark,
    required this.status,
    required this.myself,
    required this.vendorImage,
    required this.payHalfAmount,
    required this.userImage,
  });

  int id;
  int customerId;
  dynamic customerName;
  dynamic phone;
  int userId;
  dynamic vendorName;
  dynamic vendorPhone;
  int shopId;
  dynamic shopName;
  dynamic invoiceImage;
  bool payHalfAmount;
  dynamic invoiceNumber;
  dynamic invoiceDate;
  dynamic preTaxAmount;
  dynamic invoiceAmount;
  dynamic remark;
  dynamic status;
  bool myself;
  dynamic vendorImage;
  dynamic userImage;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        phone: json["phone"],
        userId: json["user_id"],
        vendorName: json["vendor_name"],
        payHalfAmount: json["pay_half_amount"],
        vendorPhone: json["vendor_phone"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"],
        invoiceDate:
            DateTime.parse(json["invoice_date"] ?? DateTime.now().toString()),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"] ?? "",
        status: json["status"],
        myself: json["myself"],
        vendorImage: json["vendor_image"],
        userImage: json["user_image"],
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
