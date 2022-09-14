import 'dart:convert';

PrabayarOperator prabayarOperatorFromJson(String str) => PrabayarOperator.fromJson(json.decode(str));

String prabayarOperatorToJson(PrabayarOperator data) => json.encode(data.toJson());

class PrabayarOperator {
  PrabayarOperator({
    this.status,
    this.info,
    this.listOperator,
  });

  bool status;
  String info;
  List<ListOperator> listOperator;

  factory PrabayarOperator.fromJson(Map<String, dynamic> json) => PrabayarOperator(
    status: json["status"],
    info: json["info"],
    listOperator: List<ListOperator>.from(json["list_operator"].map((x) => ListOperator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "info": info,
    "list_operator": List<dynamic>.from(listOperator.map((x) => x.toJson())),
  };
}

class ListOperator {
  ListOperator({
    this.id,
    this.productId,
    this.productName,
    this.productKat,
    this.listOperatorOperator,
    this.position,
    this.prefix,
    this.minDigit,
    this.maxDigit,
    this.status,
    this.alur,
    this.form,
    this.updatedAt,
    this.gambar,
    this.gambarfix,
  });

  String id;
  String productId;
  String productName;
  String productKat;
  String listOperatorOperator;
  String position;
  String prefix;
  String minDigit;
  String maxDigit;
  String status;
  String alur;
  String form;
  DateTime updatedAt;
  String gambar;
  String gambarfix;

  factory ListOperator.fromJson(Map<String, dynamic> json) => ListOperator(
    id: json["id"],
    productId: json["product_id"],
    productName: json["product_name"],
    productKat: json["product_kat"],
    listOperatorOperator: json["operator"],
    position: json["position"],
    prefix: json["prefix"],
    minDigit: json["min_digit"],
    maxDigit: json["max_digit"],
    status: json["status"],
    alur: json["alur"],
    form: json["form"],
    updatedAt: DateTime.parse(json["updated_at"]),
    gambar: json["gambar"],
    gambarfix: json["gambarfix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "product_kat": productKat,
    "operator": listOperatorOperator,
    "position": position,
    "prefix": prefix,
    "min_digit": minDigit,
    "max_digit": maxDigit,
    "status": status,
    "alur": alur,
    "form": form,
    "updated_at": updatedAt.toIso8601String(),
    "gambar": gambar,
    "gambarfix": gambarfix,
  };
}
