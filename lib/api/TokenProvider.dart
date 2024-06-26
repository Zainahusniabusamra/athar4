import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  void setFcmToken(String token) {
    _fcmToken = token;
    notifyListeners();
  }
}
