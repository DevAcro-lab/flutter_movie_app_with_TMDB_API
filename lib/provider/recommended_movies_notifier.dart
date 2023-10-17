import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../services/get_api_services/get_recommended_movies.dart';

class RecommendedMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> recommendedMoviesList = [];
  RecommendedMovies recommendedMovies = RecommendedMovies();

  Future<List<Movie>> fetchRecommendedMovies(int movieID) async {
    try {
      isLoading = true;
      notifyListeners();
      recommendedMoviesList =
          await recommendedMovies.getRecommendedMovies(movieID);
      isLoading = true;
      notifyListeners();
      return recommendedMoviesList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
