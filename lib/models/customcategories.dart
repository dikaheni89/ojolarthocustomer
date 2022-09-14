// To parse this JSON data, do
//
//     final customCategories = customCategoriesFromJson(jsonString);

import 'dart:convert';

CustomCategories customCategoriesFromJson(String str) => CustomCategories.fromJson(json.decode(str));

String customCategoriesToJson(CustomCategories data) => json.encode(data.toJson());

class CustomCategories {
  CustomCategories({
    this.message,
    this.data,
  });

  String message;
  List<CustomCategory> data;

  factory CustomCategories.fromJson(Map<String, dynamic> json) => CustomCategories(
    message: json["message"],
    data: List<CustomCategory>.from(json["data"].map((x) => CustomCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CustomCategory {
  CustomCategory({
    this.id,
    this.name,
    this.color,
    this.subcategories,
  });

  int id;
  String name;
  String color;
  List<Subcategory> subcategories;

  factory CustomCategory.fromJson(Map<String, dynamic> json) => CustomCategory(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.urlImage,
    this.urlVideo,
  });

  int id;
  String name;
  int categoryId;
  String urlImage;
  String urlVideo;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    urlImage: json["urlImage"],
    urlVideo: json["urlVideo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "urlImage": urlImage,
    "urlVideo": urlVideo,
  };
}
