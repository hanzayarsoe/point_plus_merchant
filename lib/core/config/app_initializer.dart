import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/observers/bloc_observer.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp();
    await dotenv.load(fileName: '.env');
    ApiUrls.baseUrl = dotenv.env['ENV'] == 'dev'
        ? dotenv.env['DEV_BASE_URL']!
        : dotenv.env['BASE_URL']!;
    await serviceLocater();
    await sl.allReady();
    Bloc.observer = AppBlocObserver();
  }
}
