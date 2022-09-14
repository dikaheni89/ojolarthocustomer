import 'dart:convert';

List<HistoryPascabayar> historyPascabayarFromJson(String str) => List<HistoryPascabayar>.from(json.decode(str).map((x) => HistoryPascabayar.fromJson(x)));

String historyPascabayarToJson(List<HistoryPascabayar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryPascabayar {
  HistoryPascabayar({
    this.id,
    this.idUser,
    this.refId,
    this.invoice,
    this.metode,
    this.namaPel,
    this.periode,
    this.nomor,
    this.jenis,
    this.jumlahTagihanCust,
    this.totalTagihanCust,
    this.totalBayarSky,
    this.totalBayarUser,
    this.laba,
    this.labaServer,
    this.labaSky,
    this.ket,
    this.ketSky,
    this.detailOrder,
    this.status,
    this.kode,
    this.tgl,
    this.tglUpdate,
    this.email,
    this.feeGlobal,
    this.productName,
    this.productFee,
    this.categoryName,
  });

  String id;
  String idUser;
  String refId;
  String invoice;
  String metode;
  String namaPel;
  String periode;
  String nomor;
  String jenis;
  String jumlahTagihanCust;
  String totalTagihanCust;
  String totalBayarSky;
  String totalBayarUser;
  String laba;
  String labaServer;
  String labaSky;
  String ket;
  String ketSky;
  String detailOrder;
  String status;
  String kode;
  DateTime tgl;
  DateTime tglUpdate;
  String email;
  dynamic feeGlobal;
  String productName;
  String productFee;
  String categoryName;

  factory HistoryPascabayar.fromJson(Map<String, dynamic> json) => HistoryPascabayar(
    id: json["id"],
    idUser: json["id_user"],
    refId: json["ref_id"],
    invoice: json["invoice"],
    metode: json["metode"],
    namaPel: json["nama_pel"],
    periode: json["periode"],
    nomor: json["nomor"],
    jenis: json["jenis"],
    jumlahTagihanCust: json["jumlah_tagihan_cust"],
    totalTagihanCust: json["total_tagihan_cust"],
    totalBayarSky: json["total_bayar_sky"],
    totalBayarUser: json["total_bayar_user"],
    laba: json["laba"],
    labaServer: json["laba_server"],
    labaSky: json["laba_sky"],
    ket: json["ket"],
    ketSky: json["ket_sky"],
    detailOrder: json["detail_order"],
    status: json["status"],
    kode: json["kode"],
    tgl: DateTime.parse(json["tgl"]),
    tglUpdate: DateTime.parse(json["tgl_update"]),
    email: json["email"],
    feeGlobal: json["fee_global"],
    productName: json["product_name"],
    productFee: json["product_fee"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "ref_id": refId,
    "invoice": invoice,
    "metode": metode,
    "nama_pel": namaPel,
    "periode": periode,
    "nomor": nomor,
    "jenis": jenis,
    "jumlah_tagihan_cust": jumlahTagihanCust,
    "total_tagihan_cust": totalTagihanCust,
    "total_bayar_sky": totalBayarSky,
    "total_bayar_user": totalBayarUser,
    "laba": laba,
    "laba_server": labaServer,
    "laba_sky": labaSky,
    "ket": ket,
    "ket_sky": ketSky,
    "detail_order": detailOrder,
    "status": status,
    "kode": kode,
    "tgl": tgl.toIso8601String(),
    "tgl_update": tglUpdate.toIso8601String(),
    "email": email,
    "fee_global": feeGlobal,
    "product_name": productName,
    "product_fee": productFee,
    "category_name": categoryName,
  };
}
