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
    required this.totalPages,
  });

  TotalAmountData totalAmountData;
  List<VerifiedInvoiceData> invoiceData;
  int totalPages;

  factory VerfiedModel.fromJson(Map<String, dynamic> json) => VerfiedModel(
        invoiceData: List<VerifiedInvoiceData>.from(
            json["invoice_data"].map((x) => VerifiedInvoiceData.fromJson(x))),
        totalAmountData: TotalAmountData.fromJson(json["total_amount_data"]),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_data": List<dynamic>.from(invoiceData.map((x) => x.toJson())),
        "total_amount_data": totalAmountData.toJson(),
        "total_pages": totalPages,
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
    required this.shopCommission,
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
    required this.isImport,
    required this.amountData,
    required this.payHalfAmount,
    required this.shopAddedBy,
    required this.shopBusinessRepId,
    required this.fieldVisitCommission,
    required this.addedByCommission,
    required this.shopBalanceAmount,
    required this.shopCreatedAt,
    required this.businessRepCommission,
    required this.bulkApproveStatus,
  });

  int id;
  int customerId;
  dynamic customerName;
  dynamic phone;
  dynamic userId;
  String vendorPhone;
  dynamic shopId;
  double shopCommission;
  String shopName;
  String invoiceImage;
  dynamic invoiceNumber;
  DateTime invoiceDate;
  dynamic preTaxAmount;
  dynamic invoiceAmount;
  dynamic remark;
  dynamic status;
  bool myself;
  dynamic vendorImage;
  dynamic userImage;
  bool payHalfAmount;
  bool isImport;
  dynamic shopAddedBy;
  dynamic shopBusinessRepId;
  dynamic fieldVisitCommission;
  dynamic addedByCommission;
  dynamic shopBalanceAmount;
  dynamic shopCreatedAt;
  dynamic businessRepCommission;
  dynamic bulkApproveStatus;
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
        shopCommission: json["shop_commission"],
        shopName: json["shop_name"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"],
        payHalfAmount: json["pay_half_amount"],
        invoiceDate:
            DateTime.parse(json["invoice_date"] ?? DateTime.now().toString()),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"] ?? "",
        status: json["status"],
        myself: json["myself"],
        vendorImage: json["vendor_image"],
        userImage: json["user_image"],
        isImport: json["is_import"],
        shopAddedBy: json["shop_added_by"],
        shopBusinessRepId: json["shop_business_rep_id"],
        fieldVisitCommission: json["field_visit_commission"],
        addedByCommission: json["added_by_commission"],
        shopBalanceAmount: json["shop_balance_amount"],
        shopCreatedAt: json["shop_created_at"],
        businessRepCommission: json["business_rep_commission"],
        bulkApproveStatus: json["bulk_approve_status"],
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
        "shop_commission": shopCommission,
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
        "is_import": isImport,
        "shop_added_by": shopAddedBy,
        "shop_business_rep_id": shopBusinessRepId,
        "field_visit_commission": fieldVisitCommission,
        "added_by_commission": addedByCommission,
        "shop_balance_amount": shopBalanceAmount,
        "shop_created_at": shopCreatedAt,
        "business_rep_commission": businessRepCommission,
        "bulk_approve_status": bulkApproveStatus,
        "amount_data": amountData.toJson(),
      };
}

class VerifiedAmountData {
  VerifiedAmountData({
    required this.currentAmount,
    required this.totalAmount,
    required this.commissionAmount,
    required this.additionalAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
    required this.vendorBalance,
  });

  dynamic currentAmount;
  dynamic commissionAmount;
  dynamic additionalAmount;
  dynamic totalAmount;
  dynamic vendorBalance;
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
        totalAmount: json["total_amount"],
        email: json["email"],
        vendorBalance: json["vendor_balance"],
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
    required this.shopId,
    required this.totalAmount,
    required this.shopWalletAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
    required this.dueAmount,
    required this.halfAmount,
    required this.shopBalance,
  });

  dynamic totalAmount;
  dynamic dueAmount;
  dynamic halfAmount;
  dynamic shopWalletAmount;
  String name;
  String email;
  String razorKey;
  String razorSecret;
  bool haveBank;
  String shopId;
  dynamic shopBalance;
  factory TotalAmountData.fromJson(Map<String, dynamic> json) =>
      TotalAmountData(
        totalAmount: json["total_amount"],
        shopWalletAmount: json["shop_wallet_amount"],
        shopId: json["shop_id"],
        name: json["name"],
        email: json["email"],
        razorKey: json["razor_key"],
        razorSecret: json["razor_secret"],
        haveBank: json["have_bank"],
        dueAmount: json["due_amount"],
        halfAmount: json["half_amount"],
        shopBalance: json["shop_balance"],
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
