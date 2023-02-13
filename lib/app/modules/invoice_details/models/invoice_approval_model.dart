// To parse this JSON data, do
//
//     final invoiceApprovalModel = invoiceApprovalModelFromJson(jsonString);

import 'dart:convert';

InvoiceApprovalModel invoiceApprovalModelFromJson(String str) =>
    InvoiceApprovalModel.fromJson(json.decode(str));

String invoiceApprovalModelToJson(InvoiceApprovalModel data) =>
    json.encode(data.toJson());

class InvoiceApprovalModel {
  InvoiceApprovalModel({
    required this.amount,
    required this.name,
    required this.email,
    required this.invoiceId,
    this.razorKey,
    this.razorSecret,
    required this.success,
    required this.message,
  });

  dynamic amount;
  String name;
  String email;
  dynamic invoiceId;
  dynamic razorKey;
  dynamic razorSecret;
  bool success;
  String message;

  factory InvoiceApprovalModel.fromJson(Map<String, dynamic> json) =>
      InvoiceApprovalModel(
        amount: json["amount"],
        name: json["name"] ?? "null",
        email: json["email"] ?? "null",
        invoiceId: json["invoice_id"],
        razorKey: json["razor_key"],
        razorSecret: json["razor_secret"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "name": name,
        "email": email,
        "invoice_id": invoiceId,
        "razor_key": razorKey,
        "razor_secret": razorSecret,
        "success": success,
        "message": message,
      };
}
