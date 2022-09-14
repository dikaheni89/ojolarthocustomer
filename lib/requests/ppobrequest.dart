import 'dart:convert';

import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/UrlPayment.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/prabayarcategory.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/search_data.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/models/tag.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:fuodz/services/location.service.dart';

import '../models/PascabayarCategory.dart';
import '../models/PascabayarProduct.dart';
import '../models/PrabayarOperator.dart';
import '../models/PrabayarProduct.dart';

class PPOBRequest extends HttpService {
  //
  Future<PrabayarCategory> getPrabayarCategory() async {
    final apiResult = await getPPOB(Api.prabayar,
      queryParameters: {
        "id_user" : "12",
        "metode" : 1,
        "nobuild" : 4,
      }
    );
    print(apiResult.data);
    if(apiResult.statusCode == 200){
      return PrabayarCategory.fromJson(apiResult.data);
    }

    throw apiResult.statusMessage;
  }

  Future<PrabayarOperator> getOperator(var data) async {	
    final apiResult = await getPPOB(Api.operatorprabayar,	
        queryParameters: data	
    );	
    print(apiResult.data);	
    if(apiResult.statusCode == 200){	
      return PrabayarOperator.fromJson(apiResult.data);	
    }	

    throw apiResult.statusMessage;	
  }

  Future<PrabayarProduct> getProduk(var data) async {
    final apiResult = await getPPOB(Api.produkprabayar,
        queryParameters: data
    );
    print(apiResult.data);
    if(apiResult.statusCode == 200){
      return PrabayarProduct.fromJson(apiResult.data);
    }

    throw apiResult.statusMessage;
  }

  Future postPPOBRequest(String url, var body) async {
    //
    final apiResult = await postPPOB(
      Api.payPrabayar,
      body,
    );
    print(apiResult);
    // final apiResponse = ApiResponse.fromResponse(apiResult);
    return apiResult;
  }

  Future<PascabayarCategory> getPascabayarCategory() async {	
    final apiResult = await getPPOB(Api.pascabayar,	
        queryParameters: {	
          "id" : "12",	
          "metode" : 1,	
        }	
    );	
    print(apiResult.data);	
    if(apiResult.statusCode == 200){	
      return PascabayarCategory.fromJson(apiResult.data);	
    }	

    throw apiResult.statusMessage;	
  }	

  Future<PascabayarProduct> getProdukPascabayar(String id_product) async {	
    // future is used to handle the error when calling api > Future + async or await	
    // final url = 'Order_Pascabayar/Product';	
    // var dan = "&";	
    // final param = 'id=' + "12" + dan +	
    //     'metode=' + "1" + dan +	
    //     'id_product=' + id_product;	

    final apiResult = await getPPOB(Api.produkPascabayar,	
        queryParameters: {	
          "id" : "12",	
          "metode" : 1,	
          "id_product" : id_product	
        }	
    );	
    print(apiResult.data);	
    if(apiResult.statusCode == 200){	
      return PascabayarProduct.fromJson(apiResult.data);	
    }	
  }	

  Future postPPOBOrderPascabayar(String url, var body) async {	
    //	
    final apiResult = await postPPOB(	
      Api.orderPascabayar,	
      body,	
    );	
    print(apiResult);	
    // final apiResponse = ApiResponse.fromResponse(apiResult);	
    return apiResult;	
  }	

  Future postPPOBPayPascabayar(String url, var body) async {	
    //	
    final apiResult = await postPPOB(	
      Api.payPascabayar,	
      body,	
    );	
    print(apiResult);	
    // final apiResponse = ApiResponse.fromResponse(apiResult);	
    return apiResult;	
  }	

}
