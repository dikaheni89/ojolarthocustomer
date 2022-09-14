// To parse this JSON data, do
//
//     final pascabayarCategory = pascabayarCategoryFromJson(jsonString);

import 'dart:convert';

PascabayarCategory pascabayarCategoryFromJson(String str) => PascabayarCategory.fromJson(json.decode(str));

String pascabayarCategoryToJson(PascabayarCategory data) => json.encode(data.toJson());

class PascabayarCategory {
  PascabayarCategory({
    this.status,
    this.info,
    this.code,
    this.listKategoriPascabayar,
  });

  bool status;
  String info;
  int code;
  List<ListKategoriPascabayar> listKategoriPascabayar;

  factory PascabayarCategory.fromJson(Map<String, dynamic> json) => PascabayarCategory(
    status: json["status"],
    info: json["info"],
    code: json["code"],
    listKategoriPascabayar: List<ListKategoriPascabayar>.from(json["list_kategori_pascabayar"].map((x) => ListKategoriPascabayar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "info": info,
    "code": code,
    "list_kategori_pascabayar": List<dynamic>.from(listKategoriPascabayar.map((x) => x.toJson())),
  };
}

class ListKategoriPascabayar {
  ListKategoriPascabayar({
    this.id,
    this.productId,
    this.productName,
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
  String status;
  String alur;
  String form;
  String gambar;
  DateTime updatedAt;
  String gambarfix;

  factory ListKategoriPascabayar.fromJson(Map<String, dynamic> json) => ListKategoriPascabayar(
    id: json["id"],
    productId: json["product_id"],
    productName: json["product_name"],
    status: json["status"],
    alur: json["alur"],
    form: json["form"],
    gambar: json["gambar"],
    updatedAt: DateTime.parse(json["updated_at"]),
    gambarfix: json["gambarfix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "status": status,
    "alur": alur,
    "form": form,
    "gambar": gambar,
    "updated_at": updatedAt.toIso8601String(),
    "gambarfix": gambarfix,
  };
}
