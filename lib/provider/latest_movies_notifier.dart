import 'package:flutter/cupertino.dart';
import 'package:movies_app/services/get_api_services/get_latest_movies.dart';

import '../model/movie.dart';

class LatestMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> latestMoviesList = [];
  LatestMovies latestMovies = LatestMovies();

  Future<List<Movie>> getDiscoverMovies() async {
    try {
      isLoading = true;
      notifyListeners();
      latestMoviesList = await latestMovies.fetchDiscoverMovies();
      latestMoviesList.shuffle();
      isLoading = false;
      notifyListeners();
      return latestMoviesList;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error: $e");
    }
  }
}
