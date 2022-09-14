import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kBackgroundColor = Color(0xFFFEFFFF); //White Background
const kPrimaryColor = Color(0xFFF4F7FC);
const kSecondaryColor = Color(0xFF95A5A6);
const kTextColor = Color(0xFF2857DE); //Black Color
const kTextLightColor = Color(0xFFFE7B41);
const kTextPinkColor = Color(0xFFA08B8B);
const kWhiteColor = Color(0xFFF7F7F7);
const kPinkLightColor = Color(0xFFF0E2E2);
const kPinkStrongColor = Color(0xFFE2C6C6);
const kBlueColor = Color(0xFF0047FF);
const kYellowColor = Color(0xFFFFC56D);
const kLightBlueColor = Color(0xFFE7EEFE);
const kGreyColor = Color(0xFFE6E7E9);
const kGreyColor2 = Color(0xFF828386);
const kGreyColor3 = Color(0xFFC4C4C4);
const kGreyColor4 = Color(0xFF1d8435);
const kGSecondGreyColor = Color(0xFFE5E5E5);
const kDarkGreyColor = Color(0xFF757575);
const kSelectItemColor = Color(0xFF35485d);
const kDeepBlueColor = Color(0xFF594CF5);
const kRedColor = Color(0xFFF65054);
const kBlack = Color(0xFF272C35);
const kGreenColor = Color(0xFF9DE719);
const kGreenColor2 = Color(0xFF4B8F04);
const kGreenColor3 = Color(0xFF4AD887);
const kGreenColor4 = Color(0xFF114918);
const kDarkButtonBg = Color(0xFF273546);
const kTabBarBg = Color(0xFFEEEEEE);
const kTextBlueColor = Color(0xFF5594bf);
const kWhite = Color(0xFFF4F4F4);
const kPink = Color(0xFFF0ECFA);


Future<dynamic> loadingWidget(BuildContext context) {
  return showDialog(
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
                    Text(
                      'Loading .....',
                      style: semiBoldStyle(15, kBlack),
                    )
                  ]),
            ));
      });
}

Future<dynamic> errorWidget(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        var valuerating = '';
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 120,
              child: Center(
                child: Text(
                  'Something error',
                  style: semiBoldStyle(18, kBlack),
                ),
              ),
            ),
          );
        });
      });
}

Widget coomingSoon(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        var valuerating = '';
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 120,
              child: Center(
                child: Text(
                  'Cooming Soon . . .',
                  style: boldStyle(18, kBlack),
                ),
              ),
            ),
          );
        });
      });
}

AppBar appBarv1(BuildContext context, String title) {
  return AppBar(
    backgroundColor: kBlueColor,
    toolbarHeight: 100,
    elevation: 0,
    title: Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        title,
        style: boldStyle(24, Colors.white),
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () => Navigator.of(context).pop(),
        color: Colors.black,
      ),
    ),
  );
}

Container customWidgetAppbar(BuildContext context, String text) {
  return Container(
    height: 225,
    decoration: BoxDecoration(
      image: new DecorationImage(
        image: AssetImage('assets/images/background.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(top: 30.0, bottom: 20.0, left: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 30, color: Colors.white)),
        Expanded(
          child: SizedBox(
            width: 150.0,
            height: 10.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(text,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      ],
    ),
  );
}

TextStyle boldStyle(double fontsize, Color mycolor) {
  return TextStyle(
      fontFamily: 'Poppins',
      color: mycolor,
      fontSize: fontsize,
      fontWeight: FontWeight.w700);
}

TextStyle mediumStyle(double fontsize, Color mycolor) {
  return TextStyle(
      fontFamily: 'Poppins',
      color: mycolor,
      fontSize: fontsize,
      fontWeight: FontWeight.w500);
}

TextStyle regularStyle(double fontsize, Color mycolor) {
  return TextStyle(
      fontFamily: 'Poppins',
      color: mycolor,
      fontSize: fontsize,
      fontWeight: FontWeight.w400);
}

TextStyle semiBoldStyle(double fontsize, Color mycolor) {
  return TextStyle(
      fontFamily: 'Poppins',
      color: mycolor,
      fontSize: fontsize,
      fontWeight: FontWeight.w600);
}

InputDecoration buildInputDecoration(String hintText, String asset) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue[50],
              blurRadius: 7,
              spreadRadius: 1,
              offset: Offset(3, 7),
            )
          ]),
      child: Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
          child: Image(
            image: AssetImage(asset),
            height: 36,
            width: 36,
          )),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
        color: kGreyColor2,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

InputDecoration buildInputDecorationPasscode(String hintText, String asset) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
          child: Image(
            image: AssetImage(asset),
            height: 36,
            width: 36,
          )),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
        color: kGreyColor2,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

alert(txt, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error !',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(txt),
          actions: <Widget>[
            FlatButton(
              child: Text('OK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

InputDecoration buildCustom(String hintText, String asset) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue[50],
              blurRadius: 7,
              spreadRadius: 1,
              offset: Offset(3, 7),
            )
          ]),
      child: Padding(
          padding:
          const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
          child: Image(
            image: AssetImage(
              asset,
            ),
            // width: 10,
            // height: 10,
          )),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
        color: kGreyColor2,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
class Global{	

  static const String name = "Arthopay";	
  static const String cek = "coba";	

  showDialog(String error) {	
    Fluttertoast.showToast(	
        msg: error,	
        toastLength: Toast.LENGTH_SHORT,	
        gravity: ToastGravity.BOTTOM,	
        timeInSecForIosWeb: 1,	
        backgroundColor: Colors.red,	
        textColor: Colors.white,	
        fontSize: 16.0	
    );	
  }	
}