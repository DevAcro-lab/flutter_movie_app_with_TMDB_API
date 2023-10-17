import 'dart:convert';

import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie_character.dart';
import 'package:http/http.dart' as http;

class GetMovieCharacters {
  static const String apiKey = ApiKey.apiKey;
  MovieCharacter? movieCharacter;

  Future<MovieCharacter> getMovieCharacters(int movieId) async {
    try {
      final url =
          "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";
      var response = await http.get(Uri.parse(url));
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        movieCharacter = MovieCharacter.fromJson(decodedData);
        print(movieCharacter.toString());
      } else {
        print("Response status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }
    return movieCharacter!;
  }
}
