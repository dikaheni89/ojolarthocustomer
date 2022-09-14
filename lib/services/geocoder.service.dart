import 'package:fuodz/constants/api.dart';
import 'package:fuodz/constants/app_map_settings.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/address.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/coordinates.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:singleton/singleton.dart';

export 'package:fuodz/models/address.dart';
export 'package:fuodz/models/coordinates.dart';

class GeocoderService extends HttpService {
//
  /// Factory method that reuse same instance automatically
  factory GeocoderService() =>
      Singleton.lazy(() => GeocoderService._()).instance;

  /// Private constructor
  GeocoderService._() {}

  Future<List<Address>> findAddressesFromCoordinates(
    Coordinates coordinates,
  ) async {
    //use backend api
    if (!AppMapSettings.useGoogleOnApp) {
      final apiresult = await get(
        Api.geocoderForward,
        queryParameters: {
          "lat": coordinates.latitude,
          "lng": coordinates.longitude,
        },
      );

      //
      final apiResponse = ApiResponse.fromResponse(apiresult);
      if (apiResponse.allGood) {
        return (apiResponse.data).map((e) {
          return Address().fromServerMap(e);
        }).toList();
      }

      return [];
    }
    //use in-app geocoding
    final apiKey = AppStrings.googleMapApiKey;
    final apiResult = await getExternal(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.toString()}&key=$apiKey",
    );
    //
    if (apiResult.statusCode == 200) {
      //
      Map<String, dynamic> apiResponse = apiResult.data;
      return (apiResponse["results"] as List).map((e) {
        return Address().fromMap(e);
      }).toList();
    }
    return [];
  }

  Future<List<Address>> findAddressesFromQuery(String address) async {
    //use backend api
    if (!AppMapSettings.useGoogleOnApp) {
      final apiresult = await get(
        Api.geocoderReserve,
        queryParameters: {
          "keyword": address,
        },
      );

      //
      final apiResponse = ApiResponse.fromResponse(apiresult);
      if (apiResponse.allGood) {
        return (apiResponse.data).map((e) {
          final address = Address().fromServerMap(e);
          address.gMapPlaceId = e["place_id"] ?? "";
          return address;
        }).toList();
      }

      return [];
    }
    //use in-app geocoding
    final apiKey = AppStrings.googleMapApiKey;
    final apiResult = await getExternal(
      "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$address&key=$apiKey",
    );
    //
    if (apiResult.statusCode == 200) {
      //
      Map<String, dynamic> apiResponse = apiResult.data;
      return (apiResponse["results"] as List).map((e) {
        final address = Address().fromMap(e);
        address.gMapPlaceId = e["place_id"];
        return address;
      }).toList();
    }
    return [];
  }

  Future<Address> fecthPlaceDetails(Address address) async {
    //use backend api
    if (!AppMapSettings.useGoogleOnApp) {
      final apiresult = await get(
        Api.geocoderReserve,
        queryParameters: {
          "place_id": address.gMapPlaceId,
        },
      );

      //
      final apiResponse = ApiResponse.fromResponse(apiresult);
      if (apiResponse.allGood) {
        return Address().fromServerMap(apiResponse.body as Map);
      }

      return address;
    }

    //use in-app geocoding
    final apiKey = AppStrings.googleMapApiKey;
    final apiResult = await getExternal(
      "https: //maps.googleapis.com/maps/api/place/details/json?fields=address_component,formatted_address,name,geometry&place_id=${address.gMapPlaceId}&key=$apiKey",
    );
    //
    if (apiResult.statusCode == 200) {
      //
      Map<String, dynamic> apiResponse = apiResult.data;
      address = address.fromMap(apiResponse["result"]);
      return address;
    }
    throw "Failed".tr();
  }
}
