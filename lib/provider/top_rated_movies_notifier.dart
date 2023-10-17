import 'package:flutter/cupertino.dart';
import '../model/movie.dart';
import '../services/get_api_services/get_top_rated_movies.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> topRatedMovies = [];
  TopRatedMovies topRatedMovie = TopRatedMovies();

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      isLoading = true;
      notifyListeners();

      topRatedMovies = await topRatedMovie.fetchTopRatedMovies();
      topRatedMovies.shuffle();
      isLoading = false;
      notifyListeners();

      return topRatedMovies;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error: getting top rated movies");
    }
  }
}
