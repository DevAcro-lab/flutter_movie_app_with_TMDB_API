import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;

class SessionId {
  static const String apiKey = ApiKey.apiKey;

  Future<String> createSession(String requestToken) async {
    const String url =
        "https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey";

    final Map<String, dynamic> requestBody = {
      "request_token": requestToken,
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final sessionID = responseData['session_id'];
      return sessionID;
    } else {
      throw Exception(
          "Failed to create Session. Status code is '${response.statusCode}");
    }
  }
}
