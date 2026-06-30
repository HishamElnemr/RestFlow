import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmNotificationService {
  FcmNotificationService._();

  static final FcmNotificationService instance = FcmNotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  StreamSubscription<RemoteMessage>? _onMessageSub;

  Future<void> initialize({
    required GlobalKey<ScaffoldMessengerState> messengerKey,
  }) async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    final token = await _messaging.getToken();
    if (token != null && token.isNotEmpty) {
      print('FCM Token: $token');
    } else {
      print('FCM Token: null');
    }

    _onMessageSub?.cancel();
    _onMessageSub = FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final title = notification?.title ?? 'Notification';
      final body = notification?.body ?? 'You have a new message.';

      final messengerState = messengerKey.currentState;
      if (messengerState != null) {
        messengerState.clearSnackBars();
        messengerState.showSnackBar(
          SnackBar(
            content: Text('$title\n$body'),
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        print('FCM Foreground Message: $title - $body');
      }
    });
  }

  void dispose() {
    _onMessageSub?.cancel();
  }
}
