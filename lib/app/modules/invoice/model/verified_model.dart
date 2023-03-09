// To parse this JSON data, do
//
//     final verfiedModel = verfiedModelFromJson(jsonString);

import 'dart:convert';

VerfiedModel verfiedModelFromJson(String str) =>
    VerfiedModel.fromJson(json.decode(str));

String verfiedModelToJson(VerfiedModel data) => json.encode(data.toJson());

class VerfiedModel {
  VerfiedModel({
    required this.totalAmountData,
    required this.invoiceData,
  });

  TotalAmountData totalAmountData;
  List<VerifiedInvoiceData> invoiceData;

  factory VerfiedModel.fromJson(Map<String, dynamic> json) => VerfiedModel(
        totalAmountData: TotalAmountData.fromJson(json["total_amount_data"]),
        invoiceData: List<VerifiedInvoiceData>.from(
            json["invoice_data"].map((x) => VerifiedInvoiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_amount_data": totalAmountData.toJson(),
        "invoice_data": List<dynamic>.from(invoiceData.map((x) => x.toJson())),
      };
}

class VerifiedInvoiceData {
  VerifiedInvoiceData({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
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
    required this.userImage,
    required this.amountData,
  });

  int id;
  int customerId;
  String customerName;
  String phone;
  int userId;
  String vendorPhone;
  int shopId;
  String shopName;
  String invoiceImage;
  String invoiceNumber;
  DateTime invoiceDate;
  String preTaxAmount;
  String invoiceAmount;
  String remark;
  String status;
  bool myself;
  String vendorImage;
  String userImage;
  VerifiedAmountData amountData;

  factory VerifiedInvoiceData.fromJson(Map<String, dynamic> json) =>
      VerifiedInvoiceData(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        phone: json["phone"],
        userId: json["user_id"],
        vendorPhone: json["vendor_phone"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"],
        invoiceDate: DateTime.parse(json["invoice_date"]),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"] ?? "",
        status: json["status"],
        myself: json["myself"],
        vendorImage: json["vendor_image"],
        userImage: json["user_image"],
        amountData: VerifiedAmountData.fromJson(json["amount_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "phone": phone,
        "user_id": userId,
        "vendor_phone": vendorPhone,
        "shop_id": shopId,
        "shop_name": shopName,
        "invoice_image": invoiceImage,
        "invoice_number": invoiceNumber,
        "invoice_date": invoiceDate.toIso8601String(),
        "pre_tax_amount": preTaxAmount,
        "invoice_amount": invoiceAmount,
        "remark": remark,
        "status": status,
        "myself": myself,
        "vendor_image": vendorImage,
        "user_image": userImage,
        "amount_data": amountData.toJson(),
      };
}

class VerifiedAmountData {
  VerifiedAmountData({
    required this.currentAmount,
    required this.commissionAmount,
    required this.additionalAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
  });

  dynamic currentAmount;
  dynamic commissionAmount;
  dynamic additionalAmount;
  String name;
  String email;
  String razorKey;
  String razorSecret;
  bool haveBank;

  factory VerifiedAmountData.fromJson(Map<String, dynamic> json) =>
      VerifiedAmountData(
        currentAmount: json["current_amount"],
        commissionAmount: json["commission_amount"],
        additionalAmount: json["additional_amount"],
        name: json["name"],
        email: json["email"],
        razorKey: json["razor_key"],
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
        "have_bank": haveBank,
      };
}

class TotalAmountData {
  TotalAmountData({
    required this.totalAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
    required this.shopId,
  });

  int totalAmount;
  String name;
  String email;
  String razorKey;
  String razorSecret;
  bool haveBank;
  String shopId;

  factory TotalAmountData.fromJson(Map<String, dynamic> json) =>
      TotalAmountData(
        totalAmount: json["total_amount"],
        shopId: json["shop_id"],
        name: json["name"],
        email: json["email"],
        razorKey: json["razor_key"],
        razorSecret: json["razor_secret"],
        haveBank: json["have_bank"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "name": name,
        "email": email,
        "razor_key": razorKey,
        "razor_secret": razorSecret,
        "have_bank": haveBank,
      };
}
