import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveAndGetSessionID extends ChangeNotifier {
  void saveSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("session_id", sessionId);
  }

  Future<String?> getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString("session_id");
    return sessionId;
  }
}