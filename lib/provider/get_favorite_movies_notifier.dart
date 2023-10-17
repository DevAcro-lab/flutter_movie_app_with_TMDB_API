import 'package:flutter/cupertino.dart';
import 'package:movies_app/provider/save_get_account_id_notifier.dart';
import 'package:movies_app/provider/save_get_session_id_notifier.dart';
import 'package:movies_app/services/get_api_services/get_favorite_movies.dart';

import '../model/movie.dart';

class GetFavoriteMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  GetFavoriteMovies getFavoriteMovies = GetFavoriteMovies();
  List<Movie> favoriteMoviesList = [];
  SaveAndGetAccountID saveAndGetAccountID = SaveAndGetAccountID();
  SaveAndGetSessionID saveAndGetSessionID = SaveAndGetSessionID();

  Future<void> fetchFavoriteMovies() async {
    try {
      isLoading = true;
      notifyListeners();
      favoriteMoviesList = await getFavoriteMovies.getFavoriteMovies();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error: $e");
    }
  }
}
