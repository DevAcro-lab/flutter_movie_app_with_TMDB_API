import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';

class LatestMovies {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> discoverMovies = [];

  Future<List<Movie>> fetchDiscoverMovies() async {
    String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
    try {
      var response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        discoverMovies = List<Movie>.from(
          decodedData['results'].map((e) => Movie.fromJson(e)),
        );
        return discoverMovies;
      } else {
        throw Exception("ERROR: Status code is ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
