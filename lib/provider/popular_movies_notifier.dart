import 'package:flutter/cupertino.dart';
import 'package:movies_app/model/movie.dart';
import '../services/get_api_services/get_popular_movies.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> movie = [];
  PopularMovies popularMovies = PopularMovies();

  Future<List<Movie>> getPopularMovies() async {
    try {
      isLoading = true;
      notifyListeners();
      movie = await popularMovies.fetchPopularMovies();
      movie.shuffle();
      isLoading = false;
      notifyListeners();
      return movie;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error fetching popular movies");
      return [];
    }
  }
}
