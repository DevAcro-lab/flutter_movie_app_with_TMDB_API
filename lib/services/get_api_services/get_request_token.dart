import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Token {
  final apiKey = 'ec6a26875582bf17adde351c56e1de6c';

  Future<String> createRequestToken() async {
    final url =
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final requestToken = responseData['request_token'];
      print(requestToken);
      return requestToken;
    } else {
      throw Exception('Failed to create request token');
    }
  }
}
