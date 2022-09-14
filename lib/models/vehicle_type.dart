// To parse this JSON data, do
//
//     final vehicleType = vehicleTypeFromJson(jsonString);

import 'dart:convert';
import 'package:fuodz/models/currency.dart';
import 'package:supercharged/supercharged.dart';

VehicleType vehicleTypeFromJson(String str) =>
    VehicleType.fromJson(json.decode(str));

String vehicleTypeToJson(VehicleType data) => json.encode(data.toJson());

class VehicleType {
  VehicleType({
    this.id,
    this.name,
    this.slug,
    this.baseFare,
    this.distanceFare,
    this.timeFare,
    this.minFare,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.photo,
    this.total,
    this.encrypted,
    this.currency,
  });

  int id;
  String name;
  String slug;
  double baseFare;
  double distanceFare;
  double timeFare;
  double total;
  double minFare;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String photo;
  String encrypted;
  Currency currency;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    baseFare: (json["base_fare"] ?? 0).toString().toDouble(),
    distanceFare: (json["distance_fare"] ?? 0).toString().toDouble(),
    timeFare: (json["time_fare"] ?? 0).toString().toDouble(),
    minFare: (json["min_fare"] ?? 0).toString().toDouble(),
    total: (json["total"] ?? 0).toString().toDouble(),
    isActive: json["is_active"] ?? 0,
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    formattedDate: json["formatted_date"] ?? "",
    photo: json["photo"] ?? "",
    encrypted: json["encrypted"] ?? "",
    currency: json["currency"] != null
        ? Currency.fromJSON(json["currency"] ?? "")
        : null,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "base_fare": baseFare,
        "distance_fare": distanceFare,
        "time_fare": timeFare,
        "min_fare": minFare,
        "total": total,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "photo": photo,
        "encrypted": encrypted,
        "currency": currency != null ? currency.toJson() : null,
      };
}
