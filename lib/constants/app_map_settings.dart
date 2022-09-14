import 'package:fuodz/constants/app_strings.dart';

class AppMapSettings extends AppStrings {
  static bool get useGoogleOnApp {
    if (AppStrings.env('map') == null ||
        AppStrings.env('map')["useGoogleOnApp"] == null) {
      return true;
    }
    return AppStrings.env('map')['useGoogleOnApp'] == "1";
  }

 
}
