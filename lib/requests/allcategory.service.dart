import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/AllCategory.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/banner.dart';
import 'package:fuodz/services/http.service.dart';

class AllCategoryRequest extends HttpService {
  //
  Future<AllCategory> getAllCategory({
    int vendorTypeId,
  }) async {
    final apiResult = await get(
      Api.allCategory,
      queryParameters: {
        "vendor_type_id": vendorTypeId,
      },
    );

    if (apiResult.statusCode == 200) {
      final apiResponse = AllCategory.fromJson(apiResult.data);
      return apiResponse;
    } else {
      throw apiResult.statusMessage;
    }
  }
}
