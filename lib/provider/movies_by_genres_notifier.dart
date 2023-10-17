import 'package:flutter/cupertino.dart';
import '../model/movie.dart';
import '../services/get_api_services/get_movies_by_genres.dart';

class MoviesByGenresNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> moviesByGenres = [];
  MoviesByGenres movieByGenres = MoviesByGenres();

  Future<List<Movie>> fetchMoviesByGenres(int genresID) async {
    try {
      isLoading = true;
      notifyListeners();
      moviesByGenres = await movieByGenres.getMoviesByGenres(genresID);
      moviesByGenres.shuffle();
      isLoading = false;
      notifyListeners();
      return moviesByGenres;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error: $e");
    }
  }
}
