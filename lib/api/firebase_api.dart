
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_athar_project/main.dart';

class FirebaseApi {
  final  _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initializeNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken =await _firebaseMessaging.getToken();

    print('token: $FCMToken');

   initPushNotifications();

  }

    void handleMessage(RemoteMessage? message){
      if(message ==null) return ;

      navigatorKey.currentState?.pushNamed('/notifications_screen', arguments: message,);
    }


  // Initialize  background settings
  Future initPushNotifications() async{

    FirebaseMessaging.instance.
    getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.
    listen(handleMessage);
    
  }
}