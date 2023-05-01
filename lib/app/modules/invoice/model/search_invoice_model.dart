// To parse this JSON data, do
//
//     final searchInvoiceData = searchInvoiceDataFromJson(jsonString);

import 'dart:convert';

SearchInvoiceData searchInvoiceDataFromJson(String str) =>
    SearchInvoiceData.fromJson(json.decode(str));

String searchInvoiceDataToJson(SearchInvoiceData data) =>
    json.encode(data.toJson());

class SearchInvoiceData {
  SearchInvoiceData({
    required this.invoiceData,
    required this.page,
    required this.totalPages,
  });

  List<InvoiceDatas> invoiceData;
  int page;
  int totalPages;

  factory SearchInvoiceData.fromJson(Map<String, dynamic> json) =>
      SearchInvoiceData(
        invoiceData: List<InvoiceDatas>.from(
            json["invoice_data"].map((x) => InvoiceDatas.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_data": List<dynamic>.from(invoiceData.map((x) => x.toJson())),
        "page": page,
        "total_pages": totalPages,
      };
}

class InvoiceDatas {
  InvoiceDatas({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
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
  dynamic customerName;
  dynamic phone;
  dynamic userId;
  dynamic shopId;
  dynamic shopName;
  dynamic invoiceImage;
  dynamic invoiceNumber;
  dynamic invoiceDate;
  dynamic preTaxAmount;
  dynamic invoiceAmount;
  dynamic remark;
  dynamic status;
  dynamic myself;
  dynamic vendorImage;
  dynamic userImage;
  AmountDatas amountData;

  factory InvoiceDatas.fromJson(Map<String, dynamic> json) => InvoiceDatas(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        phone: json["phone"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        invoiceImage: json["invoice_image"],
        invoiceNumber: json["invoice_number"],
        invoiceDate: DateTime.parse(json["invoice_date"]),
        preTaxAmount: json["pre_tax_amount"],
        invoiceAmount: json["invoice_amount"],
        remark: json["remark"],
        status: json["status"],
        myself: json["myself"],
        vendorImage: json["vendor_image"],
        userImage: json["user_image"],
        amountData: AmountDatas.fromJson(json["amount_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "phone": phone,
        "user_id": userId,
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

class AmountDatas {
  AmountDatas({
    required this.currentAmount,
    required this.commissionAmount,
    required this.additionalAmount,
    required this.name,
    required this.email,
    required this.razorKey,
    required this.razorSecret,
    required this.haveBank,
  });

  int currentAmount;
  int commissionAmount;
  int additionalAmount;
  String name;
  String email;
  String razorKey;
  String razorSecret;
  bool haveBank;

  factory AmountDatas.fromJson(Map<String, dynamic> json) => AmountDatas(
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
