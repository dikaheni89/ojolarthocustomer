import 'dart:convert';

PrabayarProduct prabayarProductFromJson(String str) => PrabayarProduct.fromJson(json.decode(str));

String prabayarProductToJson(PrabayarProduct data) => json.encode(data.toJson());

class PrabayarProduct {
  PrabayarProduct({
    this.status,
    this.info,
    this.listProduct,
  });

  bool status;
  String info;
  List<ListProduct> listProduct;

  factory PrabayarProduct.fromJson(Map<String, dynamic> json) => PrabayarProduct(
    status: json["status"],
    info: json["info"],
    listProduct: List<ListProduct>.from(json["list_product"].map((x) => ListProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "info": info,
    "list_product": List<dynamic>.from(listProduct.map((x) => x.toJson())),
  };
}

class ListProduct {
  ListProduct({
    this.id,
    this.categoryId,
    this.categoryName,
    this.operatorId,
    this.operatorName,
    this.productId,
    this.productName,
    this.productDetail,
    this.productSyarat,
    this.productZona,
    this.productPrice,
    this.productMulti,
    this.productOp,
    this.position,
    this.laba,
    this.hargaFix,
    this.hargaUser,
    this.status,
    this.statusData,
    this.alur,
    this.form,
    this.updatedAt,
  });

  String id;
  String categoryId;
  String categoryName;
  String operatorId;
  String operatorName;
  String productId;
  String productName;
  String productDetail;
  String productSyarat;
  String productZona;
  String productPrice;
  String productMulti;
  String productOp;
  String position;
  String laba;
  String hargaFix;
  int hargaUser;
  String status;
  String statusData;
  String alur;
  String form;
  DateTime updatedAt;

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    operatorId: json["operator_id"],
    operatorName: json["operator_name"],
    productId: json["product_id"],
    productName: json["product_name"],
    productDetail: json["product_detail"],
    productSyarat: json["product_syarat"],
    productZona: json["product_zona"],
    productPrice: json["product_price"],
    productMulti: json["product_multi"],
    productOp: json["product_op"],
    position: json["position"],
    laba: json["laba"],
    hargaFix: json["harga_fix"],
    hargaUser: json["harga_user"],
    status: json["status"],
    statusData: json["status_data"],
    alur: json["alur"],
    form: json["form"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "operator_id": operatorId,
    "operator_name": operatorName,
    "product_id": productId,
    "product_name": productName,
    "product_detail": productDetail,
    "product_syarat": productSyarat,
    "product_zona": productZona,
    "product_price": productPrice,
    "product_multi": productMulti,
    "product_op": productOp,
    "position": position,
    "laba": laba,
    "harga_fix": hargaFix,
    "harga_user": hargaUser,
    "status": status,
    "status_data": statusData,
    "alur": alur,
    "form": form,
    "updated_at": updatedAt.toIso8601String(),
  };
}
