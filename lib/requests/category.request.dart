import 'package:flutter/foundation.dart' as Foundation;
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/services/http.service.dart';
import '../models/customcategories.dart';

class CategoryRequest extends HttpService {
  //
  Future<List<Category>> categories({
    int vendorTypeId,
    int page = 0,
    int full = 0,
  }) async {
    final apiResult = await get(
      //
      Api.categories,
      queryParameters: {
        "vendor_type_id": vendorTypeId,
        "page": page,
        "full": full,
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    } else {
      throw apiResponse.message;
    }
  }

  Future<CustomCategories> getSubCategories({
    String vendor_type_id,
  }) async {
    final apiResult = await get(
      Api.subcategories,
      queryParameters: {
        "vendor_type_id": vendor_type_id,
      },
    );
    if(Foundation.kDebugMode){
      print("Cek");
      print(apiResult.data);
    }

    final apiResponse = customCategoriesFromJson(apiResult.data.toString());

    if (apiResult.statusCode == 200) {
      return apiResponse;
    } else {
      throw apiResponse.message;
    }
  }
}
