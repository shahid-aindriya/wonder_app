class PaymentData {
  bool? success;
  String? message;
  String? encryptKey;
  String? accessCode;
  String? paymentUrl;
  String? redirectUrl;
  String? cancelUrl;

  PaymentData(
      {this.success,
      this.message,
      this.encryptKey,
      this.accessCode,
      this.paymentUrl,
      this.redirectUrl,
      this.cancelUrl});

  PaymentData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    encryptKey = json['encrypt_key'];
    accessCode = json['access_code'];
    paymentUrl = json['payment_url'];
    redirectUrl = json['redirect_url'];
    cancelUrl = json['cancel_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['encrypt_key'] = encryptKey;
    data['access_code'] = accessCode;
    data['payment_url'] = paymentUrl;
    data['redirect_url'] = redirectUrl;
    data['cancel_url'] = cancelUrl;
    return data;
  }
}
