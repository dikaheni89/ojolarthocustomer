import 'package:flutter/material.dart';
final String path = 'assets/images/ref/';

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}

List imageList = [
  {'name': 'el', 'title': 'Electricity'},
  {'name': 'air', 'title': 'Airlines'},
  {'name': 'router', 'title': 'Internet'},
  {'name': 'tv', 'title': 'TV'},
  {'name': 'umb', 'title': 'Insurance'},
  {'name': 'sas', 'title': 'Sasto Tickets'},
  {'name': 'icon_more', 'title': 'Load More'},
];

List imageList2 = [
  {'name': 'el', 'title': 'Electricity'},
  {'name': 'air', 'title': 'Airlines'},
  {'name': 'router', 'title': 'Internet'},
  {'name': 'tv', 'title': 'TV'},
  {'name': 'umb', 'title': 'Insurance'},
  {'name': 'sas', 'title': 'Sasto Tickets'},
  // {'name': 'icon_more', 'title': 'Load More'},
];

final List categories = [
  {'image': path + 'ic_username.png', 'title': 'My Account'},
  {'image': path + 'esewa.jpg', 'title': 'Load eSewa'},
  {'image': path + 'ic_payments_64_4.png', 'title': 'Payment'},
  {'image': path + 'ic_transfer_32_4.png', 'title': 'Fund Transfer'},
  {'image': path + 'ic_sch_payment_64_4.png', 'title': 'Schedule Payment'},
  {'image': path + 'ic_scan2pay_64_4.png', 'title': 'Scan To Pay'},
];