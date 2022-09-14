import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/ppobrequest.dart';
import 'package:fuodz/requests/vendor_type.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';

import '../models/PascabayarCategory.dart';
import '../models/prabayarcategory.dart';

class WelcomeViewModel extends MyBaseViewModel {
  //
  WelcomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  Widget selectedPage;
  List<VendorType> vendorTypes = [];
  List<ListCategory> listCatPrabayar = [];
  List<ListKategoriPascabayar> listCatPascabayar = [];	
  PrabayarCategory prabayarCategory;
  PascabayarCategory pascabayarCategory;
  VendorTypeRequest vendorTypeRequest = VendorTypeRequest();
  bool showGrid = true;
  StreamSubscription authStateSub;

  //
  //
  initialise() async {
    await getVendorTypes();
    prabayarCategory = await PPOBRequest().getPrabayarCategory();
    pascabayarCategory = await PPOBRequest().getPascabayarCategory();
    if(prabayarCategory != null){
      listCatPrabayar = [];
      listCatPrabayar.addAll(prabayarCategory.listCategory);
    }
    if(pascabayarCategory != null){	
      listCatPascabayar = [];	
      listCatPascabayar.addAll(pascabayarCategory.listKategoriPascabayar);	
    }
    listenToAuth();
  }

  listenToAuth() {
    authStateSub = AuthServices.listenToAuthState().listen((event) {
      genKey = GlobalKey();
      notifyListeners();
    });
  }

  getVendorTypes() async {
    setBusy(true);
    try {
      vendorTypes = await vendorTypeRequest.index();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }
}
