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
    required this.page,
    required this.totalPages,
  });
  dynamic page;
  dynamic totalPages;

  List<InvoiceDatum> invoiceData;

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        invoiceData: List<InvoiceDatum>.from(
            json["invoice_data"].map((x) => InvoiceDatum.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_data": List<dynamic>.from(invoiceData.map((x) => x.toJson())),
      };
}

class InvoiceDatum {
  InvoiceDatum({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.shopId,
    required this.invoiceImage,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.preTaxAmount,
    required this.invoiceAmount,
    required this.remark,
    required this.status,
    required this.myself,
    required this.amountData,
    required this.vendorImage,
    required this.userImage,
  });

  dynamic id;
  dynamic customerId;
  String? customerName;
  dynamic phone;
  dynamic userId;
  dynamic shopId;
  dynamic invoiceImage;
  dynamic invoiceNumber;
  dynamic invoiceDate;
  dynamic preTaxAmount;
  dynamic invoiceAmount;
  dynamic remark;
  dynamic status;
  bool myself;
  dynamic vendorImage;
  dynamic userImage;

  AmountData amountData;

  factory InvoiceDatum.fromJson(Map<String, dynamic> json) => InvoiceDatum(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"] ?? "null",
        phone: json["phone"] ?? "null",
        userId: json["user_id"],
        shopId: json["shop_id"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"] ?? "",
        invoiceDate: DateTime.parse(
            json["invoice_date"] ?? DateTime.now().toIso8601String()),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"] ?? "null",
        status: json["status"],
        vendorImage: json["vendor_image"],
        userImage: json["user_image"],
        myself: json["myself"],
        amountData:
            AmountData.fromJson(json["amount_data"] ?? {"null": "null"}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "phone": phone,
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
    this.razorKey,
    this.razorSecret,
    required this.haveBank,
  });

  dynamic currentAmount;
  dynamic commissionAmount;
  dynamic additionalAmount;
  String name;
  dynamic haveBank;
  String email;
  dynamic razorKey;
  dynamic razorSecret;

  factory AmountData.fromJson(Map<String, dynamic> json) => AmountData(
        currentAmount: json["current_amount"] ?? "null",
        commissionAmount: json["commission_amount"] ?? "null",
        additionalAmount: json["additional_amount"] ?? "null",
        name: json["name"] ?? "null",
        email: json["email"] ?? "null",
        razorKey: json["razor_key"] ?? "null",
        razorSecret: json["razor_secret"] ?? "null",
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
