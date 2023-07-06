// To parse this JSON data, do
//
//     final bankTransactionModel = bankTransactionModelFromJson(jsonString);

import 'dart:convert';

BankTransactionModel bankTransactionModelFromJson(String str) =>
    BankTransactionModel.fromJson(json.decode(str));

String bankTransactionModelToJson(BankTransactionModel data) =>
    json.encode(data.toJson());

class BankTransactionModel {
  List<TransactionDatum> transactionData;

  BankTransactionModel({
    required this.transactionData,
  });

  factory BankTransactionModel.fromJson(Map<String, dynamic> json) =>
      BankTransactionModel(
        transactionData: List<TransactionDatum>.from(
            json["transaction_data"].map((x) => TransactionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaction_data":
            List<dynamic>.from(transactionData.map((x) => x.toJson())),
      };
}

class TransactionDatum {
  dynamic id;
  dynamic customerId;
  dynamic userId;
  dynamic razorpayTransactionId;
  dynamic entryType;
  dynamic amount;
  dynamic bank;
  dynamic razorpayStatus;
  dynamic paymentType;
  dynamic transactionStatus;

  TransactionDatum({
    required this.id,
    this.customerId,
    required this.userId,
    required this.razorpayTransactionId,
    required this.entryType,
    required this.amount,
    required this.bank,
    required this.razorpayStatus,
    required this.paymentType,
    required this.transactionStatus,
  });

  factory TransactionDatum.fromJson(Map<String, dynamic> json) =>
      TransactionDatum(
        id: json["id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        razorpayTransactionId: json["razorpay_transaction_id"],
        entryType: json["entry_type"],
        amount: json["amount"],
        bank: json["bank"],
        razorpayStatus: json["razorpay_status"],
        paymentType: json["payment_type"],
        transactionStatus: json["transaction_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "user_id": userId,
        "razorpay_transaction_id": razorpayTransactionId,
        "entry_type": entryType,
        "amount": amount,
        "bank": bank,
        "razorpay_status": razorpayStatus,
        "payment_type": paymentType,
        "transaction_status": transactionStatus,
      };
}
