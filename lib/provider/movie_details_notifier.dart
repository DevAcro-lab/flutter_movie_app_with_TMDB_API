import 'package:flutter/cupertino.dart';
import '../model/movie_details.dart';
import '../services/get_api_services/get_movie_details.dart';

class MovieDetailsNotifier extends ChangeNotifier {
  bool isLoading = false;
  MovieDetails? movieDetails;
  MoviesDetails moviesDetails = MoviesDetails();

  Future<MovieDetails> fetchMovieDetails(int movieID) async {
    try {
      isLoading = true;
      notifyListeners();
      movieDetails = await moviesDetails.getMovieDetails(movieID);
      isLoading = false;
      notifyListeners();
      return movieDetails!;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error: $e");
    }
  }
}
