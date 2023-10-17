import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';
import 'package:http/http.dart' as http;

class PopularMovies {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> popularMovies = [];

  Future<List<Movie>> fetchPopularMovies() async {
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        popularMovies = List<Movie>.from(
            decodedData['results'].map((e) => Movie.fromJson(e)));
        return popularMovies;
      } else {
        throw Exception('Failed to fetch ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Can't fetch $e");
    }
  }
}
