import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';
import 'package:http/http.dart' as http;

class RecommendedMovies {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> recommendedMoviesList = [];

  Future<List<Movie>> getRecommendedMovies(int movieID) async {
    final url =
        "https://api.themoviedb.org/3/movie/$movieID/recommendations?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    var decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      recommendedMoviesList = List<Movie>.from(
          decodedData["results"].map((e) => Movie.fromJson(e)));

      return recommendedMoviesList;
    } else {
      print("Status code: ${response.statusCode}");
    }
    return recommendedMoviesList;
  }
}
