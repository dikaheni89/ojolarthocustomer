import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomWebviewPage extends StatefulWidget {
  //
  CustomWebviewPage({
    Key key,
    this.selectedUrl,
  }) : super(key: key);

  final String selectedUrl;

  @override
  _CustomWebviewPageState createState() => _CustomWebviewPageState();
}

class _CustomWebviewPageState extends State<CustomWebviewPage> {
  //
  String pageTitle = "";
  String selectedUrl = "";
  bool isLoading = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    ///
    selectedUrl = widget.selectedUrl.replaceFirst("http://", "https://");
    if (!selectedUrl.contains("?")) {
      selectedUrl = "$selectedUrl?lan=${I18n.localeStr}";
    } else {
      selectedUrl = "$selectedUrl&lan=${I18n.localeStr}";
    }

    setState(() {
      selectedUrl = selectedUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return BasePage(
      showAppBar: true,
      showLeadingAction: true,
      title: pageTitle,
      leading: IconButton(
        icon: Icon(
          FlutterIcons.arrow_left_fea,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      body: VStack(
        [
          //loading
          Visibility(
            visible: isLoading,
            child: LinearProgressIndicator(),
          ),
          //page
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse(selectedUrl)),
            initialOptions: options,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrlString(url)) {
                  // Launch the App
                  await launchUrlString(
                    url,
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              pullToRefreshController?.endRefreshing();
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController?.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController.endRefreshing();
              }
              setState(() {
                this.progress = progress / 100;
                urlController.text = this.url;
                isLoading = this.progress != 1;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ).expand(),
        ],
      ),
    );
  }
}
