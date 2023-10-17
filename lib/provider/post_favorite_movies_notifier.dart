import 'package:flutter/cupertino.dart';
import 'package:movies_app/provider/get_favorite_movies_notifier.dart';
import 'package:movies_app/services/post_api_services/post_favorite_movie.dart';

class PostFavoriteMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  PostFavoriteMovie postFavoriteMovie = PostFavoriteMovie();

  Future<void> addMovieToFavList(context, int movieId) async {
    try {
      isLoading = true;
      notifyListeners();
      postFavoriteMovie.postFavoriteMovies(context, movieId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }
}
