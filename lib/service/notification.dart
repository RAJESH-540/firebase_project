import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

class NotificationService{
  static Future<void> initialize()async{
    NotificationSettings notificationSettings= await FirebaseMessaging.instance.requestPermission();
    if(notificationSettings.authorizationStatus== AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
      FirebaseMessaging.onMessage.listen((message) {
        log("Message Receieved ${message.notification?.title}");
      });
      log("Notification Authorized");
    }
  }
}
Future<void> BackgroundHandler(RemoteMessage remoteMessage)async{
  log("message received ${remoteMessage.notification?.title}");
}