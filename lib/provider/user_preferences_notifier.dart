import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  static const sessionKey = "session_id";

  // Store session id
  static Future<void> storeSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sessionKey, sessionId);
  }

  // get session id
  static Future<String?> getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString(sessionKey);
    return sessionId;
  }

  // check if session id is stored
  static Future<bool> isSessionStored() async {
    final sessionId = await getSessionId();
    return sessionId != null;
  }

  // Remove the session stored id
  static Future<void> removeSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionKey);
  }
}
