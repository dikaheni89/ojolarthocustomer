import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/payment/custom_webview.page.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class PaymentViewModel extends MyBaseViewModel {
  refreshDataSet() {}
  //
  // openWebpageLink(String url) async {
  //   //
  //   try {
  //     ChromeSafariBrowser browser = new MyChromeSafariBrowser();
  //     await browser.open(
  //       url: Uri.parse(url),
  //       options: ChromeSafariBrowserClassOptions(
  //         android: AndroidChromeCustomTabsOptions(
  //           addDefaultShareMenuItem: false,
  //           enableUrlBarHiding: true,
  //         ),
  //         ios: IOSSafariOptions(
  //           barCollapsingEnabled: true,
  //         ),
  //       ),
  //     );
  //   } catch (error) {
  //     await launchUrlString(url);
  //   }
  //   //
  //   refreshDataSet();
  // }

  openWebpageLink(String url, {bool external = false}) async {
    if(kDebugMode){
      print(url);
    }
    if (Platform.isIOS || external) {
      await launchUrlString(url);
      return;
    }
    await viewContext.push(
      (context) => CustomWebviewPage(
        selectedUrl: url,
      ),
    );

    refreshDataSet();
  }

}
