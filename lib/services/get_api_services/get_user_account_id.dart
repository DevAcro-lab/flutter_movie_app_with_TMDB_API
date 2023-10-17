import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/provider/save_get_account_id_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetUserID {
  static const String apiKey = ApiKey.apiKey;

  Future<int> getUserId(String sessionId) async {
    final String url =
        'https://api.themoviedb.org/3/account?api_key=$apiKey&session_id=$sessionId';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Uri uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> accountDetails = jsonDecode(response.body);
      final int accountId = accountDetails['id'];
      print('User Account ID: $accountId');
      return accountId;
    } else {
      throw Exception(
          'Failed to fetch user account details: ${response.statusCode}');
    }
  }
}
