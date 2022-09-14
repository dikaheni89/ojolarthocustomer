// To parse this JSON data, do
//
//     final allCategory = allCategoryFromJson(jsonString);

import 'dart:convert';

AllCategory allCategoryFromJson(String str) => AllCategory.fromJson(json.decode(str));

String allCategoryToJson(AllCategory data) => json.encode(data.toJson());

class AllCategory {
  AllCategory({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.color,
    this.subcategories,
    this.idgym
  });

  int id;
  String name;
  String color;
  int idgym;
  List<Subcategory> subcategories;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    idgym: json["idgym"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "idgym": idgym,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.urlImage,
    this.idgym,
  });

  int id;
  String name;
  int categoryId;
  String urlImage;
  int idgym;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    urlImage: json["urlImage"],
    idgym: json["idgym"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "urlImage": urlImage,
    "idgym": idgym,
  };
}
