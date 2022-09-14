import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuodz/my_app.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/services/general_app.service.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:fuodz/services/firebase.service.dart';
import 'package:fuodz/services/notification.service.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'constants/app_languages.dart';
import 'constants/preference.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
//ssll handshake error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await translator.init(
        localeType: LocalizationDefaultType.asDefined,
        languagesList: AppLanguages.codes,
        assetsDirectory: 'assets/lang/',
      );
      //
      await Preference().instance();
      await LocalStorageService.getPrefs();
      await CartServices.getCartItems();
      //setting up firebase notifications
      await Preference().instance();
      await initPlugin();
      _configureLocalTimeZone();
      if(!kIsWeb){
        await NotificationService.clearIrrelevantNotificationChannels();
        await NotificationService.initializeAwesomeNotification();
        await NotificationService.listenToActions();
      }
      await FirebaseService().setUpFirebaseMessaging();
      FirebaseMessaging.onBackgroundMessage(GeneralAppService.onBackgroundMessageHandler);
      //prevent ssl error
      HttpOverrides.global = new MyHttpOverrides();
      if(!kIsWeb){
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      }
      // Run app!
      print("Start the app");
      runApp(
        I18n(
          initialLocale: Locale(AuthServices.getLocale()),
          child: LocalizedApp(child: MyApp()),
        ),
      );
    },
    (error, stackTrace) {
      if(!kIsWeb){
        FirebaseCrashlytics.instance.recordError(error, stackTrace);
      }

    },
  );
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> initPlugin() async {
  try {
    final TrackingStatus status =
    await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      var _authStatus = await AppTrackingTransparency.requestTrackingAuthorization();
      Preference.shared.setString(Preference.TRACK_STATUS, _authStatus.toString());
    }
  } on PlatformException {}

  final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  print("UUID:" + uuid);
}
