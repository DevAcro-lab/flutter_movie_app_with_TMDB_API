import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';
import 'package:http/http.dart' as http;

class TopRatedMovies {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> topRatedMovies = [];
  String url = "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        topRatedMovies = List<Movie>.from(
            decodedData['results'].map((e) => Movie.fromJson(e)));
        return topRatedMovies;
      } else {
        throw Exception("Error: status code is ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
