import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/model/genres.dart';

class GenresClass {
  static const String apiKey = ApiKey.apiKey;
  String url = "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey";
  List<Genres> categories = [];

  Future<List<Genres>?> getGenres() async {
    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        categories = List<Genres>.from(
            decodedData['genres'].map((e) => Genres.fromJson(e)));
        return categories;
      } else {
        print("Error: STATUS CODE: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return null;
  }
}
