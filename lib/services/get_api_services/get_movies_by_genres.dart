import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';
import 'package:http/http.dart' as http;

class MoviesByGenres {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> moviesByGenres = [];

  Future<List<Movie>> getMoviesByGenres(int genresID) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genresID";
    try {
      final response = await http.get(Uri.parse(url));
      var decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        moviesByGenres = List<Movie>.from(
            decodedData["results"].map((e) => Movie.fromJson(e)));

        return moviesByGenres;
      } else {
        print("Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return moviesByGenres;
  }
}
