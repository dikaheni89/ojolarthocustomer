import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuodz/models/PrabayarOperator.dart';
import 'package:fuodz/services/local_storage.service.dart';

import 'dart:convert';

import '../../../constants/api.dart';
import '../../../constants/global.dart';
import '../../../models/PrabayarProduct.dart';
import '../../../requests/ppobrequest.dart';

class PrabayarScreen extends StatefulWidget {
  String nama, categoryID, urlGambar;
  PrabayarScreen({
    @required this.nama,
    @required this.categoryID,
    @required this.urlGambar
  });
  @override
  _PrabayarScreen createState() => _PrabayarScreen();
}

class _PrabayarScreen extends State<PrabayarScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _noMeterText = TextEditingController();
  String nohandpone = "";
  String paket;

  int _radioValue = 0;

  String kategori;
  List<ListProduct> listProduk = [];
  PrabayarProduct prabayarProduct;
  PrabayarOperator prabayarOperator;
  List<ListOperator> listOperator = [];

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    super.initState();
    getOperator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.nama)
      ),
      body: Container(
        color: kBackgroundColor,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

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
                // color: kBackgroundColor,
                height: 179,
                child: Column(
                  children: [
                    Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                          controller: _noMeterText,
                          enableSuggestions: true,
                          autocorrect: false,
                          onSaved: (val) {
                            setState(() {
                              nohandpone = val;
                              print(nohandpone);
                            });
                          },
                          onChanged: (text) {
                            //onchPhone(text);
                          },
                          style: boldStyle(18, kBlack),
                          keyboardType: TextInputType.number,
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
                                        _noMeterText.clear();
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
                            //   context,
                            //   new MaterialPageRoute(
                            //       builder: (context) =>
                            //       new HistoryScreen()),
                            // );
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
              const SizedBox(height: 8.0),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 600,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: listProduk.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        splashFactory: InkRipple.splashFactory,
                        onTap: () {
                          print(listProduk[i].productName);
                          setState(() {
                            paket = listProduk[i].productId;
                            // print(paket + " : " + listProduk[i].productId);
                          });
                        },
                        child: Container(
                          height: 60,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color: paket == listProduk[i].productId
                                      ? kGreyColor
                                      : kBackgroundColor,
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              child: Text(
                                listProduk[i].productName,
                                style: boldStyle(14, kBlack),
                              )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: kBackgroundColor,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proses',
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
    );
  }

  Widget showKota() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: kategori,
        items: _dropDownMenuItems,
        onChanged: (String val) {
          changedDropDownItem(val);
          getData(val);
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
    for (ListOperator dtin in listOperator) {
      print(dtin.productName);
      items.add(new DropdownMenuItem(
          value: dtin.productId, child: new Text(dtin.productName)));
    }
    return items;
  }

  void changedDropDownItem(String pk) {
    print(pk);
    setState(() {
      kategori = pk;
    });
  }

  void _submit() async {
    _formKey.currentState.save();
    if (nohandpone != "") {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Container(
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('LOADING .....', style: TextStyle(color: Colors.black))
                      ]),
                ));
          });

      // Read value
      String username = await LocalStorageService.prefs.get("email");
      String password = await LocalStorageService.prefs.get("password");
      var url, body;
      //String id = _dt[int.parse(paket)]['id'];

      url = 'Order_Prabayar/pay_prabayar';
      body = {
        'email': username.toString(),
        'password': password.toString(),
        'destination': nohandpone,
        'id_user': "12",
        'id_product': paket,
        'metode': "serpul",
        'laba': "0",
        'harga': "0",
      };

      print(body.toString());
      final response = await PPOBRequest().postPPOBRequest(url, body);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      // print(response.body);

      // print("respone code : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var user = response.data;

        if (user['status'] == true) {
          print(user);
          // Navigator.of(context, rootNavigator: true).pop('dialog');
          //_showDialog(context, user['msg']);
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          // Navigator.push(
          //   context,
          //   new MaterialPageRoute(builder: (context) => new SuccessPage()),
          // );
        } else {
          print(user);
          // Navigator.of(context, rootNavigator: true).pop('dialog');
          Fluttertoast.showToast(
              msg: user['info'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          // Global().showDialog(user['info']);
        }
      } else {
        print(body);
      }
      print('Form submitted');
    } else {
      Fluttertoast.showToast(
          msg: "Mohon isi Form dengan lengkap !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Global().showDialog('Mohon isi Form dengan lengkap !');
    }
  }

  Future<void> getOperator() async {
    listProduk = [];
    setState(() {

    });
    // final storage = new FlutterSecureStorage();
    //

    var dan = "&";
    var body = {
      "id_user" : 12,
      "metode" : "1",
      "id_kat" : widget.categoryID,
    };

    final response = await PPOBRequest().getOperator(body);
    print(response.info);
    // if(kDebugMode){
    //   print(response.body.toString());
    // }


    prabayarOperator = response;

    listOperator.addAll(prabayarOperator.listOperator);
    _dropDownMenuItems = getDropDownMenuItems();
    if(listOperator.isNotEmpty){
      await getData(listOperator.first.productId);
    }

    // return listProduk;

    //paket = _dropDownMenuItems[0].value;
  }

  Future<void> getData(String idOperator) async {
    listProduk = [];
    setState(() {

    });
    var body = {
      "id_user" : 12,
      "metode" : "1",
      "id_product" : idOperator,
    };

    final response = await PPOBRequest().getProduk(body);
    print(response.info);
    prabayarProduct = response;

    listProduk.addAll(prabayarProduct.listProduct);
    setState(() {

    });
    // return listProduk;

    //paket = _dropDownMenuItems[0].value;
  }
}