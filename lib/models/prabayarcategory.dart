// To parse this JSON data, do
//
//     final prabayarCategory = prabayarCategoryFromJson(jsonString);

import 'dart:convert';

PrabayarCategory prabayarCategoryFromJson(String str) => PrabayarCategory.fromJson(json.decode(str));

String prabayarCategoryToJson(PrabayarCategory data) => json.encode(data.toJson());

class PrabayarCategory {
  PrabayarCategory({
    this.status,
    this.info,
    this.code,
    this.listCategory,
  });

  bool status;
  String info;
  String code;
  List<ListCategory> listCategory;

  factory PrabayarCategory.fromJson(Map<String, dynamic> json) => PrabayarCategory(
    status: json["status"],
    info: json["info"],
    code: json["code"],
    listCategory: List<ListCategory>.from(json["list_category"].map((x) => ListCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "info": info,
    "code": code,
    "list_category": List<dynamic>.from(listCategory.map((x) => x.toJson())),
  };
}

class ListCategory {
  ListCategory({
    this.id,
    this.productId,
    this.productName,
    this.statusPrefix,
    this.status,
    this.alur,
    this.form,
    this.gambar,
    this.updatedAt,
    this.gambarfix,
  });

  String id;
  String productId;
  String productName;
  Status statusPrefix;
  Status status;
  Alur alur;
  Form form;
  String gambar;
  DateTime updatedAt;
  String gambarfix;

  factory ListCategory.fromJson(Map<String, dynamic> json) => ListCategory(
    id: json["id"],
    productId: json["product_id"],
    productName: json["product_name"],
    statusPrefix: statusValues.map[json["status_prefix"]],
    status: statusValues.map[json["status"]],
    alur: alurValues.map[json["alur"]],
    form: formValues.map[json["form"]],
    gambar: json["gambar"],
    updatedAt: DateTime.parse(json["updated_at"]),
    gambarfix: json["gambarfix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "status_prefix": statusValues.reverse[statusPrefix],
    "status": statusValues.reverse[status],
    "alur": alurValues.reverse[alur],
    "form": formValues.reverse[form],
    "gambar": gambar,
    "updated_at": updatedAt.toIso8601String(),
    "gambarfix": gambarfix,
  };
}

enum Alur { SERPUL, DIGIFLAZZ }

final alurValues = EnumValues({
  "digiflazz": Alur.DIGIFLAZZ,
  "serpul": Alur.SERPUL
});

enum Form { UPDATED }

final formValues = EnumValues({
  "updated": Form.UPDATED
});

enum Status { ACTIVE, EMPTY }

final statusValues = EnumValues({
  "ACTIVE": Status.ACTIVE,
  "": Status.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
