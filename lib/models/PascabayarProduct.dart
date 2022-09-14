import 'dart:convert';

PascabayarProduct produkPascabayarFromJson(String str) => PascabayarProduct.fromJson(json.decode(str));

String produkPascabayarToJson(PascabayarProduct data) => json.encode(data.toJson());

class PascabayarProduct {
  PascabayarProduct({
    this.status,
    this.info,
    this.listProdukPascabayar,
  });

  bool status;
  String info;
  List<ListProdukPascabayar> listProdukPascabayar;

  factory PascabayarProduct.fromJson(Map<String, dynamic> json) => PascabayarProduct(
    status: json["status"],
    info: json["info"],
    listProdukPascabayar: List<ListProdukPascabayar>.from(json["list_produk_pascabayar"].map((x) => ListProdukPascabayar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "info": info,
    "list_produk_pascabayar": List<dynamic>.from(listProdukPascabayar.map((x) => x.toJson())),
  };
}

class ListProdukPascabayar {
  ListProdukPascabayar({
    this.id,
    this.categoryId,
    this.categoryName,
    this.productId,
    this.productName,
    this.productFee,
    this.status,
    this.alur,
    this.form,
    this.gambar,
    this.updatedAt,
    this.gambarfix,
  });

  String id;
  String categoryId;
  String categoryName;
  String productId;
  String productName;
  String productFee;
  String status;
  String alur;
  String form;
  String gambar;
  DateTime updatedAt;
  String gambarfix;

  factory ListProdukPascabayar.fromJson(Map<String, dynamic> json) => ListProdukPascabayar(
    id: json["id"].toString(),
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    productId: json["product_id"],
    productName: json["product_name"],
    productFee: json["product_fee"],
    status: json["status"],
    alur: json["alur"],
    form: json["form"],
    gambar: json["gambar"],
    updatedAt: DateTime.parse(json["updated_at"]),
    gambarfix: json["gambarfix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "product_id": productId,
    "product_name": productName,
    "product_fee": productFee,
    "status": status,
    "alur": alur,
    "form": form,
    "gambar": gambar,
    "updated_at": updatedAt,
    "gambarfix": gambarfix,
  };
}
