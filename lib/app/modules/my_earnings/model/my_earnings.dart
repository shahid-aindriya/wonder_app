// To parse this JSON data, do
//
//     final myEarnings = myEarningsFromJson(jsonString);

import 'dart:convert';

MyEarnings myEarningsFromJson(String str) =>
    MyEarnings.fromJson(json.decode(str));

String myEarningsToJson(MyEarnings data) => json.encode(data.toJson());

class MyEarnings {
  dynamic shopEarnings;
  List<TransactionDatum> transactionData;
  dynamic page;
  dynamic totalPages;

  MyEarnings({
    required this.shopEarnings,
    required this.transactionData,
    required this.page,
    required this.totalPages,
  });

  factory MyEarnings.fromJson(Map<String, dynamic> json) => MyEarnings(
        shopEarnings: json["shop_earnings"],
        transactionData: List<TransactionDatum>.from(
            json["transaction_data"].map((x) => TransactionDatum.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "shop_earnings": shopEarnings,
        "transaction_data":
            List<dynamic>.from(transactionData.map((x) => x.toJson())),
        "page": page,
        "total_pages": totalPages,
      };
}

class TransactionDatum {
  dynamic id;
  dynamic customerId;
  dynamic customerName;
  dynamic phone;
  dynamic userId;
  dynamic shopId;
  dynamic amount;
  dynamic walletType;
  dynamic entryType;
  dynamic remark;
  dynamic status;
  dynamic createdAt;

  TransactionDatum({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.shopId,
    required this.amount,
    required this.walletType,
    required this.entryType,
    required this.remark,
    required this.status,
    required this.createdAt,
  });

  factory TransactionDatum.fromJson(Map<String, dynamic> json) =>
      TransactionDatum(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        phone: json["phone"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        amount: json["amount"],
        walletType: json["wallet_type"],
        entryType: json["entry_type"],
        remark: json["remark"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "phone": phone,
        "user_id": userId,
        "shop_id": shopId,
        "amount": amount,
        "wallet_type": walletType,
        "entry_type": entryType,
        "remark": remark,
        "status": status,
        "created_at": createdAt,
      };
}
