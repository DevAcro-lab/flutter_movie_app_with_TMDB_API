import 'dart:convert';
import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;

class ValidateUserEmailAndPassword {
  static const String apiKey = ApiKey.apiKey;

  Future<String?> validateEmailAndPassword(
      String requestToken, String username, String password) async {
    String url =
        "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$apiKey";

    Map<String, dynamic> requestBody = {
      'request_token': requestToken,
      'username': username,
      'password': password,
    };

    final response = await http.post(Uri.parse(url), body: requestBody);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final requestToken = responseData['request_token'];
        return requestToken;
      } else {
        final errorMessage = responseData['status_message'];
        throw Exception(errorMessage);
      }
    } else {
      print(
          "requestToken: $requestToken, username: $username, password: $password");
      throw Exception(
          "Failed to validate login, status code: ${response.statusCode}");
    }
  }
}
