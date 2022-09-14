// To parse this JSON data, do
//
//     final urlPayment = urlPaymentFromJson(jsonString);

import 'dart:convert';

UrlPayment urlPaymentFromJson(String str) => UrlPayment.fromJson(json.decode(str));

String urlPaymentToJson(UrlPayment data) => json.encode(data.toJson());

class UrlPayment {
  UrlPayment({
    this.id,
    this.gateway,
    this.response,
    this.paymentUrl,
    this.createdAt,
    this.updatedAt,
    this.orderCode,
  });

  String id;
  String gateway;
  Response response;
  String paymentUrl;
  DateTime createdAt;
  DateTime updatedAt;
  String orderCode;

  factory UrlPayment.fromJson(Map<String, dynamic> json) => UrlPayment(
    id: json["id"],
    gateway: json["gateway"],
    response: Response.fromJson(json["response"]),
    paymentUrl: json["paymentUrl"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    orderCode: json["order_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gateway": gateway,
    "response": response.toJson(),
    "paymentUrl": paymentUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "order_code": orderCode,
  };
}

class Response {
  Response({
    this.merchantCode,
    this.reference,
    this.paymentUrl,
    this.vaNumber,
    this.amount,
    this.statusCode,
    this.statusMessage,
  });

  String merchantCode;
  String reference;
  String paymentUrl;
  String vaNumber;
  String amount;
  String statusCode;
  String statusMessage;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    merchantCode: json["merchantCode"],
    reference: json["reference"],
    paymentUrl: json["paymentUrl"],
    vaNumber: json["vaNumber"],
    amount: json["amount"],
    statusCode: json["statusCode"],
    statusMessage: json["statusMessage"],
  );

  Map<String, dynamic> toJson() => {
    "merchantCode": merchantCode,
    "reference": reference,
    "paymentUrl": paymentUrl,
    "vaNumber": vaNumber,
    "amount": amount,
    "statusCode": statusCode,
    "statusMessage": statusMessage,
  };
}
