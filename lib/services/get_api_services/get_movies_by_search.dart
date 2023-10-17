import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;
import '../../model/movie.dart';

class GetMoviesBySearch {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> searchedMoviesList = [];

  Future<List<Movie>> getMoviesBySearch(String query) async {
    final String url =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query";
    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        searchedMoviesList = List<Movie>.from(
            decodedData["results"].map((e) => Movie.fromJson(e)));
        return searchedMoviesList;
      } else {
        throw Exception("${response.statusCode}");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
