import 'dart:convert';
import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/model/movie.dart';
import '../../model/movie_details.dart';

class MoviesDetails {
  static const String apiKey = ApiKey.apiKey;
  MovieDetails? movieDetails;

  Future<MovieDetails> getMovieDetails(int movieID) async {
    try {
      final url = "https://api.themoviedb.org/3/movie/$movieID?api_key=$apiKey";
      final response = await http.get(Uri.parse(url));
      var decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        movieDetails = MovieDetails.fromJson(decodedData);
      } else {
        print("Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return movieDetails!;
  }
}
