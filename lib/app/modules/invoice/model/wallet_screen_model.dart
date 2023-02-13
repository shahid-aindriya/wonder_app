// To parse this JSON data, do
//
//     final walletScreenModel = walletScreenModelFromJson(jsonString);

import 'dart:convert';

WalletScreenModel walletScreenModelFromJson(String str) =>
    WalletScreenModel.fromJson(json.decode(str));

String walletScreenModelToJson(WalletScreenModel data) =>
    json.encode(data.toJson());

class WalletScreenModel {
  WalletScreenModel({
    required this.shopWalletAmount,
    required this.transactionData,
  });

  String shopWalletAmount;
  List<TransactionDatum> transactionData;

  factory WalletScreenModel.fromJson(Map<String, dynamic> json) =>
      WalletScreenModel(
        shopWalletAmount: json["shop_wallet_amount"],
        transactionData: List<TransactionDatum>.from(
            json["transaction_data"].map((x) => TransactionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shop_wallet_amount": shopWalletAmount,
        "transaction_data":
            List<dynamic>.from(transactionData.map((x) => x.toJson())),
      };
}

class TransactionDatum {
  TransactionDatum({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.shopId,
    required this.invoiceNumber,
    required this.amount,
    this.bankTransactionId,
    required this.walletType,
    required this.entryType,
    required this.remark,
    required this.status,
  });

  int id;
  int customerId;
  String customerName;
  String phone;
  int userId;
  int shopId;
  String invoiceNumber;
  String amount;
  dynamic bankTransactionId;
  String walletType;
  String entryType;
  String remark;
  String status;

  factory TransactionDatum.fromJson(Map<String, dynamic> json) =>
      TransactionDatum(
        id: json["id"],
        customerId: json["customer_id"] ?? "null",
        customerName: json["customer_name"] ?? "null",
        phone: json["phone"] ?? "null",
        userId: json["user_id"] ?? "null",
        shopId: json["shop_id"] ?? "null",
        invoiceNumber: json["invoice_number"] ?? "null",
        amount: json["amount"] ?? "null",
        bankTransactionId: json["bank_transaction_id"] ?? "null",
        walletType: json["wallet_type"] ?? "null",
        entryType: json["entry_type"] ?? "null",
        remark: json["remark"] ?? "null",
        status: json["status"] ?? "null",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_name": customerName,
        "phone": phone,
        "user_id": userId,
        "shop_id": shopId,
        "invoice_number": invoiceNumber,
        "amount": amount,
        "bank_transaction_id": bankTransactionId,
        "wallet_type": walletType,
        "entry_type": entryType,
        "remark": remark,
        "status": status,
      };
}
