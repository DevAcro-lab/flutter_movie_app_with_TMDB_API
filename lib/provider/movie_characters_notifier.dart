import 'package:flutter/cupertino.dart';
import 'package:movies_app/model/movie_character.dart';

import '../services/get_api_services/get_movie_characters.dart';

class MovieCharactersNotifier extends ChangeNotifier {
  bool isLoading = false;
  MovieCharacter? movieCharacter;
  GetMovieCharacters getMovieCharacters = GetMovieCharacters();

  Future<MovieCharacter> fetchMovieCharacters(int movieId) async {
    try {
      isLoading = true;
      notifyListeners();

      movieCharacter = await getMovieCharacters.getMovieCharacters(movieId);

      isLoading = false;
      notifyListeners();
      return movieCharacter!;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }
}
