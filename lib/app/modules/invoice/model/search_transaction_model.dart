// To parse this JSON data, do
//
//     final searchWalletTransaction = searchWalletTransactionFromJson(jsonString);

import 'dart:convert';

SearchWalletTransaction searchWalletTransactionFromJson(String str) =>
    SearchWalletTransaction.fromJson(json.decode(str));

String searchWalletTransactionToJson(SearchWalletTransaction data) =>
    json.encode(data.toJson());

class SearchWalletTransaction {
  SearchWalletTransaction({
    required this.transactionData,
    required this.page,
    required this.totalPages,
  });

  List<WalletTransactionDatum> transactionData;
  int page;
  int totalPages;

  factory SearchWalletTransaction.fromJson(Map<String, dynamic> json) =>
      SearchWalletTransaction(
        transactionData: List<WalletTransactionDatum>.from(
            json["transaction_data"]
                .map((x) => WalletTransactionDatum.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_data":
            List<dynamic>.from(transactionData.map((x) => x.toJson())),
        "page": page,
        "total_pages": totalPages,
      };
}

class WalletTransactionDatum {
  WalletTransactionDatum({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.userId,
    required this.shopId,
    this.invoiceNumber,
    required this.amount,
    this.bankTransactionId,
    required this.walletType,
    required this.entryType,
    required this.remark,
    required this.status,
    required this.createdAt,
  });

  int id;
  int customerId;
  String customerName;
  String phone;
  int userId;
  int shopId;
  dynamic invoiceNumber;
  String amount;
  dynamic bankTransactionId;
  String walletType;
  String entryType;
  String remark;
  String status;
  String createdAt;

  factory WalletTransactionDatum.fromJson(Map<String, dynamic> json) =>
      WalletTransactionDatum(
        id: json["id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        phone: json["phone"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        invoiceNumber: json["invoice_number"],
        amount: json["amount"],
        bankTransactionId: json["bank_transaction_id"],
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
        "invoice_number": invoiceNumber,
        "amount": amount,
        "bank_transaction_id": bankTransactionId,
        "wallet_type": walletType,
        "entry_type": entryType,
        "remark": remark,
        "status": status,
        "created_at": createdAt,
      };
}
