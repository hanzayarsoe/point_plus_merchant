import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/observers/bloc_observer.dart';
import 'package:merchant/core/services/firebase_messaging_service.dart';
import 'package:merchant/core/services/local_notifications_service.dart';
import 'package:merchant/firebase_options.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final LocalNotificationsService localNotificationsService =
        LocalNotificationsService.instance();
    await localNotificationsService.init();
    await serviceLocater();
    await sl.allReady();

    final FirebaseMessagingService firebaseMessagingService =
        FirebaseMessagingService.instance();
    await firebaseMessagingService.init(
      localNotificationsService: localNotificationsService,
    );
    await dotenv.load(fileName: '.env');
    ApiUrls.baseUrl = dotenv.env['ENV'] == 'dev'
        ? dotenv.env['DEV_BASE_URL']!
        : dotenv.env['BASE_URL']!;
    Bloc.observer = AppBlocObserver();
  }
}
