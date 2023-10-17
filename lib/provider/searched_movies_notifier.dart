import 'package:flutter/cupertino.dart';
import '../model/movie.dart';
import '../services/get_api_services/get_movies_by_search.dart';

class SearchMoviesNotifier extends ChangeNotifier {
  GetMoviesBySearch getMoviesBySearch = GetMoviesBySearch();
  List<Movie> searchMoviesList = [];
  bool isLoading = false;

  Future<List<Movie>> fetchSearchedMovies(String query) async {
    try {
      isLoading = true;
      notifyListeners();

      searchMoviesList = await getMoviesBySearch.getMoviesBySearch(query);

      isLoading = false;
      notifyListeners();
      return searchMoviesList;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      throw Exception(e);
    }
  }

  void clearSearchList() {
    searchMoviesList.clear();
    notifyListeners();
  }
}
