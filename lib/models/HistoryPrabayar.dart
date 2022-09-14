import 'dart:convert';

List<HistoryPrabayar> historyPrabayarFromJson(String str) => List<HistoryPrabayar>.from(json.decode(str).map((x) => HistoryPrabayar.fromJson(x)));

String historyPrabayarToJson(List<HistoryPrabayar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryPrabayar {
  HistoryPrabayar({
    this.id,
    this.idUser,
    this.refId,
    this.nomor,
    this.jenis,
    this.harga,
    this.hargaAsli,
    this.laba,
    this.ket,
    this.ketSky,
    this.status,
    this.kode,
    this.serialCode,
    this.tgl,
    this.tglUpdate,
    this.email,
    this.feeGlobal,
    this.productName,
    this.productPrice,
    this.operatorName,
  });

  String id;
  String idUser;
  String refId;
  String nomor;
  String jenis;
  String harga;
  String hargaAsli;
  String laba;
  String ket;
  String ketSky;
  Status status;
  String kode;
  String serialCode;
  String tgl;
  DateTime tglUpdate;
  Email email;
  String feeGlobal;
  String productName;
  String productPrice;
  String operatorName;

  factory HistoryPrabayar.fromJson(Map<String, dynamic> json) => HistoryPrabayar(
    id: json["id"],
    idUser: json["id_user"],
    refId: json["ref_id"],
    nomor: json["nomor"],
    jenis: json["jenis"],
    harga: json["harga"],
    hargaAsli: json["harga_asli"],
    laba: json["laba"],
    ket: json["ket"],
    ketSky: json["ket_sky"],
    status: statusValues.map[json["status"]],
    kode: json["kode"],
    serialCode: json["serial_code"],
    tgl: json["tgl"],
    tglUpdate: DateTime.parse(json["tgl_update"]),
    email: emailValues.map[json["email"]],
    feeGlobal: json["fee_global"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    operatorName: json["operator_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "ref_id": refId,
    "nomor": nomor,
    "jenis": jenis,
    "harga": harga,
    "harga_asli": hargaAsli,
    "laba": laba,
    "ket": ket,
    "ket_sky": ketSky,
    "status": statusValues.reverse[status],
    "kode": kode,
    "serial_code": serialCode,
    "tgl": tgl,
    "tgl_update": tglUpdate.toIso8601String(),
    "email": emailValues.reverse[email],
    "fee_global": feeGlobal,
    "product_name": productName,
    "product_price": productPrice,
    "operator_name": operatorName,
  };
}

enum Email { ESHALGLOBALCIPTA_GMAIL_COM }

final emailValues = EnumValues({
  "eshalglobalcipta@gmail.com": Email.ESHALGLOBALCIPTA_GMAIL_COM
});

enum Status { SUCCESS }

final statusValues = EnumValues({
  "SUCCESS": Status.SUCCESS
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
