import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuodz/requests/ppobrequest.dart';
import 'dart:convert';

import '../../../constants/Contants.dart';
import '../../../constants/global.dart';
import '../../../constants/rupiah.dart';
import '../../../models/PascabayarProduct.dart';
import '../../../services/local_storage.service.dart';

class PascabayarScreen extends StatefulWidget {
  String nama, categoryID, urlGambar;
  PascabayarScreen({
    @required this.nama,
    @required this.categoryID,
    @required this.urlGambar
  });

  @override
  _PascabayarScreen createState() => _PascabayarScreen();
}

class _PascabayarScreen extends State<PascabayarScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final storage = new FlutterSecureStorage();

  String nohandpone = "";
  String area = "";
  String paket;
  TextEditingController _noHpText = TextEditingController();
  List<ListProdukPascabayar> _dt = [];
  String metode = "", id_produk='', gambar='';
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    super.initState();
    getData(widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.nama)
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(color: kBackgroundColor, boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(1, 5),
                    )
                  ]),
                  height: 80,
                  child: Row(
                    children: [
                      Image(
                        image: NetworkImage(widget.urlGambar),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.nama,
                        style: boldStyle(14, kBlack),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: kBackgroundColor, boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(1, 5),
                    )
                  ]),
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          width: double.infinity,
                          child: Text(
                            'Kategori',
                            style: semiBoldStyle(14, kGreyColor2),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        // padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kPink,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        width: double.infinity,
                        child: Container(
                            height: 41,
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: showKota()
                        ),
                      ),
                      Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          width: double.infinity,
                          child: Text(
                            'Nomor Pelanggan',
                            style: semiBoldStyle(14, kGreyColor2),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kPink,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        width: double.infinity,
                        child: Container(
                          height: 41,
                          width: 150,
                          child: TextFormField(
                            maxLines: 1,
                            controller: _noHpText,
                            enableSuggestions: true,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              //onchPhone(text);
                            },
                            onSaved: (val) {
                              setState(() {
                                nohandpone = val;
                                print(nohandpone);
                              });
                            },
                            style: boldStyle(18, kBlack),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              suffixIcon: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close_outlined,
                                        color: kGreyColor2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _noHpText.clear();
                                        });
                                        ;
                                      },
                                    )),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              hintText: 'Contoh : 1234567890',
                              hintStyle: semiBoldStyle(14, kGreyColor2),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     new MaterialPageRoute(
                              //         builder: (context) =>
                              //         new HistoryPpob(code: 'PDAM')));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: kBlack,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'History',
                                  style: mediumStyle(15, kBlack),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Container(
                  color: Colors.white,
                  height: 100,
                  child: Center(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () => _submit(paket, _noHpText.text, metode, "PDAM"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Proses Ke Pembayaran',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kGreenColor2,
                          elevation: 0,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      )
    );

  }

  String loading ="";
  void CustomBeliPascabayar(destination, nama, periode, jumlahtagihan,
      total_tagihan, tarif, daya, stand_meter, laba, totalbayar, ref_id, String admin){

    loading = "";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.padding),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions:[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: Constants.padding,
                            top: Constants.avatarRadius + Constants.padding,
                            right: Constants.padding,
                            bottom: Constants.padding),
                        margin: EdgeInsets.only(top: Constants.avatarRadius),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Constants.padding),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                            ]),
                        child: loading==null || loading==""
                            ? DetailWidget(destination, nama, periode, jumlahtagihan,
                            total_tagihan, tarif, daya, stand_meter, laba,
                            totalbayar, ref_id, setState2, admin)
                            : SuksesWidget(),
                      ),

                      Positioned(
                        left: Constants.padding,
                        right: Constants.padding,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Constants.avatarRadius,
                          child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                              child: Image.asset("assets/logo.png")),
                        ),
                      ),
                    ],
                  )
                ]
            );
          },
        );
      },
    );
  }

  Widget DetailWidget(destination, nama, periode, jumlahtagihan,
      total_tagihan, tarif, daya, stand_meter, laba, totalbayar, ref_id, setState2, String admin){
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Card(
          color: Colors.blue[100],
          child: Image.network(gambar,
            height: 70,
          ),
        ),
        SizedBox(height: 15,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "No Pelanggan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              destination,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),


        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Nama",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              nama,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Periode",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              periode,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Jumlah Tagihan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              rupiah(jumlahtagihan)+",00",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Biaya Admin",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              rupiah(admin),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Total Tagihan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              rupiah(total_tagihan)+",00",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        if(tarif != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Tarif",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              Text(
                tarif,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),

            ],
          ),

        SizedBox(height: 5,),

        if(daya != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Daya",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              Text(
                daya,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),

            ],
          ),

        // SizedBox(height: 5,),
        //
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //
        //     Text(
        //       "Stand Meter",
        //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        //     ),
        //
        //     Text(
        //       stand_meter,
        //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        //     ),
        //
        //   ],
        // ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Laba",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              laba,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(height: 5,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              "Total Bayar",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            Text(
              rupiah(totalbayar)+",00",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),

          ],
        ),

        SizedBox(
          height: 22,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Batal",
                  style: TextStyle(fontSize: 18),
                )),

            ElevatedButton(
                onPressed: () async {
                  print("konfirmasi");
                  setState2(() {
                    loading = "1";
                  });
                  await pay_Pascabayar("12", ref_id, metode,
                      setState2, id_produk, destination);
                  // loading="2";

                },
                child: Text(
                  "Konfirmasi",
                  style: TextStyle(fontSize: 18),
                )),

          ],
        )
      ],
    );
  }

  Widget SuksesWidget(){
    print(loading);

    if(loading=="1"){

      return  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
              height: 100,
              width: 200,
              child: Column(
                children: [

                  CircularProgressIndicator(
                    semanticsLabel: "Cek",
                  ),

                  SizedBox(height: 10,),

                  Text(
                    "Data sedang diproses mohon menunggu sebentar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal,
                        color: Colors.blue),
                  ),

                ],
              )

          )


        ],
      );

    }else if(loading=="2"){

      return  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Card(
            color: Colors.blue[100],
            child: Image.asset("assets/images/done.gif",
              height: 70,
            ),
          ),

          Text(
            "Pembayaran tagihan anda berhasil",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),

        ],
      );

    }else{
      return Container();
    }

  }

  String loadingcek = "0";

  void _submit(String id_product, String destination, metode, String id_kat) async {
    _formKey.currentState.save();
    if (nohandpone != "") {
      Global().showDialog("Memuat Data");
      print(id_product + ":" + destination + ":" + metode + ":" + id_kat);
      var url = "Order_Pascabayar/order_pascabayar";
      print(url.toString());
      // String username = await storage.read(key: 'username');
      // String password = await storage.read(key: 'password');
      String username = await LocalStorageService.prefs.get("email");
      String password = await LocalStorageService.prefs.get("password");
      var body = {
        "id_user": "12",
        "id_product": id_product,
        "id_kategori" : id_kat,
        "destination": destination,
        "metode": metode,
        "email": username,
        "password": password,

      };
      print(body.toString());
      final response = await PPOBRequest().postPPOBPayPascabayar(url, body);

      setState(() {
        loadingcek="0";
      });
      print(response.body);
      var data = json.decode(response.body);
      // Navigator.of(context, rootNavigator: true).pop();



      if (data["status"] == null) {

        Global().showDialog('Mohon maaf, Server kami sedang mengalami masalah"');

      } else if (data["status"] == false) {

        Global().showDialog(data['info']);

      } else {

        Global().showDialog(data['info']);

        String admin            = "";
        String namapel          = data['data']['nama_pel'];
        String periode          = data['data']['periode'];
        String jumlahtagihan    = data['data']['jumlah_tagihan_cust'].toString();
        String total_tagihan    = data['data']['total_tagihan_cust'].toString();
        String ref_id           = data['data']['ref_id'];

        if(metode == "qiosfin"){
          admin                   = data['data']['detail_order']['biaya_admin'].toString();
        }else{
          admin                   = data['data']['detail_order']['admin'].toString();
        }

        String daya             = "";
        String stand_meter      = "";
        String tarif            = "";

        if(data['data']['detail_order']['desc'] == null){

        }else{

          if(data['data']['detail_order']['desc']['daya'] == null){

          }else{
            tarif            = data['data']['detail_order']['desc']['tarif'];
            daya             = data['data']['detail_order']['desc']['daya'].toString();
            // stand_meter      = data['data']['detail'][2]['value'];
          }

        }

        String laba             = "";
        String totalbayar       = "";
        laba                  = data['data']['laba'].toString();
        totalbayar            = data['data']['total_bayar_user'].toString();
        // if(pascabayarController.akses=="owner"){
        //   laba                  = data['data']['laba_sky'].toString();
        //   totalbayar            = data['data']['total_bayar_sky'].toString();
        //   // Get.find<DashboardOwnerController>().getInfoUser();
        //
        // }else{
        //   laba                  = data['data']['laba'].toString();
        //   totalbayar            = data['data']['total_bayar_user'].toString();
        //   // Get.find<DashboardMemberController>().getInfoUser();
        // }

        CustomBeliPascabayar(destination, namapel, periode, jumlahtagihan,
            total_tagihan, tarif, daya, stand_meter,
            laba, totalbayar, ref_id, admin);
      }
    } else {
      Global().showDialog('Mohon isi Form dengan lengkap !');
    }
  }

  Future<void> pay_Pascabayar(String id_user, String ref_id, String metode, setState2,
      String id_product, String destination) async {

    print(id_user+" : "+ref_id+" : "+metode + " : " + id_product + " : " + destination );
    var url = "Order_Pascabayar/pay_pascabayar";
    print(url.toString());
    // String username = await storage.read(key: 'username');
    // String password = await storage.read(key: 'password');
    String username = await LocalStorageService.prefs.get("email");
    String password = await LocalStorageService.prefs.get("password");

    var body = {
      "id_user": "12",
      "ref_id": ref_id,
      "metode": metode,
      "id_product": id_product,
      "destination": destination,
      "email": username,
      "password": password,

    };
    print(body.toString());
    final response = await PPOBRequest().postPPOBRequest(url, body);

    print(response.body);
    var data = json.decode(response.body);



    if(data["status"]==null) {
      Global().showDialog("Mohon maaf, Server kami sedang mengalami masalah");

      Future.delayed(Duration(seconds: 2)).then((value) {
        setState2(() {
          loading = "";
        });
      });

    }else if(data["status"]==false){
      Global().showDialog(data['info']);

      Future.delayed(Duration(seconds: 2)).then((value) {
        setState2(() {
          loading = "";
        });
      });


    }else{
      Global().showDialog(data['info']);

      // if(pascabayarController.akses == 'owner'){
      //   Get.find<DashboardOwnerController>().getInfoUser();
      // }else{
      //   Get.find<DashboardMemberController>().getInfoUser();
      // }

      await Future.delayed(Duration(seconds: 2)).then((value) {
        setState2(() {
          loading = "2";
        });
      });

      await Future.delayed(Duration(seconds: 2));
      Fluttertoast.showToast(
          msg: "Transaksi Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Navigator.push(
      //   context,
      //   new MaterialPageRoute(
      //       builder: (context) =>
      //           SuccessPage()),
      // );

    }
  }

  getData(String id_kategori) async {
    // id_kat = id_kategori;
    // listProdukPasca = [];
    var productTemp = await PPOBRequest().getProdukPascabayar(id_kategori);

    if (productTemp.status == false) {
      Global().showDialog(productTemp.info);
      // code = listOperator.code;
    } else {
      _dt = [];
      _dt.addAll(productTemp.listProdukPascabayar);
      _dropDownMenuItems = getDropDownMenuItems();
      if (_dt.length > 0) {
        id_produk = _dt[0].productId;
        gambar = _dt[0].gambarfix;
        metode = _dt[0].alur;
      }

    }
    setState(() {

    });
  }

  Widget showKota() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: paket,
        items: _dropDownMenuItems,
        onChanged: (String val) {
          changedDropDownItem(val);
        },
        hint: Text(
          'Pilih Kategori',
          style: semiBoldStyle(14, kGreyColor2),
        ),
        isExpanded: true,
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (ListProdukPascabayar dtin in _dt) {
      print(dtin.productName);
      items.add(new DropdownMenuItem(
          value: dtin.productId, child: new Text(dtin.productName)));
    }
    return items;
  }

  void changedDropDownItem(String pk) {
    print(pk);
    setState(() {
      paket = pk;
    });
  }

  _showDialog(BuildContext context, error) {
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text(error)));
    final snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
