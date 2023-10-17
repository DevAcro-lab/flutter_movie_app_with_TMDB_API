import 'package:flutter/cupertino.dart';
import '../model/genres.dart';
import '../services/get_api_services/get_genres.dart';

class GenresNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Genres> genres = [];
  GenresClass genresClass = GenresClass();

  Future<List<Genres>> fetchGenres() async {
    try {
      isLoading = false;
      notifyListeners();

      genres = (await genresClass.getGenres())!;

      isLoading = false;
      notifyListeners();
      return genres;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
