import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_router.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/services/local_notifications_service.dart';
import 'package:merchant/core/storage/secure_storage.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';

class FirebaseMessagingService {
  // Private constructor for singleton pattern
  FirebaseMessagingService._internal();

  // Singleton instance
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  // Factory constructor to provide singleton instance
  factory FirebaseMessagingService.instance() => _instance;

  // Reference to local notifications service for displaying notifications
  LocalNotificationsService? _localNotificationsService;

  /// Initialize Firebase Messaging and sets up all message listeners
  Future<void> init({
    required LocalNotificationsService localNotificationsService,
  }) async {
    // Init local notifications service
    _localNotificationsService = localNotificationsService;
    _localNotificationsService?.setOnNotificationTapHandler(
      _onLocalNotificationTap,
    );

    // Request user permission for notifications
    final permissionSettings = await _requestPermission();

    // Disable system notifications while app is in the foreground (iOS).
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: false,
          badge: false,
          sound: false,
        );

    // Handle FCM token after permission is granted
    final status = permissionSettings.authorizationStatus;
    if (status == AuthorizationStatus.authorized ||
        status == AuthorizationStatus.provisional) {
      await _handlePushNotificationsToken();
    }

    // Register handler for background messages (app terminated)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listen for messages when the app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // Listen for notification taps when the app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Check for initial message that opened the app from terminated state
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageData(initialMessage.data);
    }
  }

  Future<void> _handlePushNotificationsToken() async {
    if (Platform.isIOS) {
      final apnsToken = await _waitForApnsToken();
      if (apnsToken == null) {
        debugPrint(
          'APNs token not available yet; skipping initial FCM token fetch.',
        );
      } else {
        debugPrint('APNs token ready.');
      }
    }

    // Get the FCM token for the device
    try {
      if (!Platform.isIOS ||
          await FirebaseMessaging.instance.getAPNSToken() != null) {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null && token.isNotEmpty) {
          await _storeAndSyncToken(token);
        }
      }
    } catch (error) {
      debugPrint('Error fetching FCM token: $error');
    }

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) async {
          debugPrint('FCM token refreshed: $fcmToken');
          await _storeAndSyncToken(fcmToken);
        })
        .onError((error) {
          // Handle errors during token refresh
          debugPrint('Error refreshing FCM token: $error');
        });
  }

  Future<String?> _waitForApnsToken({
    int maxAttempts = 20,
    Duration delay = const Duration(milliseconds: 300),
  }) async {
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null && apnsToken.isNotEmpty) {
        return apnsToken;
      }
      await Future.delayed(delay);
    }
    return null;
  }

  Future<void> _storeAndSyncToken(String token) async {
    await sl<SecureStorage>().saveFcmToken(token);
    final bool isNotiEnabled = await sl<NotiCubit>().loadNoti();
    if (isNotiEnabled) {
      await sl<NotiCubit>().registerToken(token);
    } else {
      await sl<NotiCubit>().unregisterToken(token);
    }
  }

  /// Requests notification permission from the user
  Future<NotificationSettings> _requestPermission() async {
    // Request permission for alerts, badges, and sounds
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Log the user's permission decision
    debugPrint('User granted permission: ${result.authorizationStatus}');
    return result;
  }

  /// Handles messages received while the app is in the foreground
  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.data.toString()}');
    final notificationData = message.notification;
    final payload = message.data.isNotEmpty ? jsonEncode(message.data) : null;
    // Display a local notification using the service.
    _localNotificationsService?.showNotification(
      notificationData?.title ?? message.data['title']?.toString(),
      notificationData?.body ?? message.data['body']?.toString(),
      payload,
    );
  }

  /// Handles notification taps when app is opened from the background or terminated state
  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint(
      'Notification caused the app to open: ${message.data.toString()}',
    );
    _handleMessageData(message.data);
  }

  void _onLocalNotificationTap(String? payload) {
    if (payload == null || payload.isEmpty) {
      return;
    }
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic>) {
        _handleMessageData(decoded);
      } else if (decoded is Map) {
        _handleMessageData(Map<String, dynamic>.from(decoded));
      } else {
        debugPrint('Notification payload is not a map: $payload');
      }
    } catch (error) {
      debugPrint('Failed to decode notification payload: $error');
    }
  }

  void _handleMessageData(Map<String, dynamic> data) {
    if (data.isEmpty) {
      debugPrint('Notification data empty; skipping navigation.');
      return;
    }
    final requestId = data['requestId']?.toString();
    final transactionId = data['transactionId']?.toString();
    if ((requestId == null || requestId.isEmpty) &&
        (transactionId == null || transactionId.isEmpty)) {
      debugPrint('Notification missing route ids: $data');
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appRouter = sl<AppRouter>();
      if (requestId != null && requestId.isNotEmpty) {
        appRouter.router.goNamed(
          AppRoutes.requestTransactionDetail,
          pathParameters: {"id": requestId},
        );
      } else if (transactionId != null && transactionId.isNotEmpty) {
        appRouter.router.goNamed(
          AppRoutes.transactionDetail,
          pathParameters: {"id": transactionId},
        );
      }
    });
  }
}

/// Background message handler (must be top-level function or static)
/// Handles messages when the app is fully terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message received: ${message.data.toString()}');
}
