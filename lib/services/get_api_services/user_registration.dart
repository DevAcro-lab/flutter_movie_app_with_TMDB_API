import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;

class UserRegistration {
  static const String apiKey = ApiKey.apiKey;

  Future<void> registerUser(
      String email, String password, String requestToken) async {
    String url =
        "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$apiKey";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          "username": email,
          "password": password,
          "request_token": requestToken,
        },
      ),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final sessionId = responseData['session_id'];
      return sessionId;
    } else {
      throw Exception('Failed to create session with login');
    }
  }
}
