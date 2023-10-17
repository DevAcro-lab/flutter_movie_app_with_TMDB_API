import 'dart:convert';
import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/model/movie.dart';
import 'package:http/http.dart' as http;
import '../../provider/save_get_account_id_notifier.dart';
import '../../provider/save_get_session_id_notifier.dart';
import 'get_session_id.dart';

class GetFavoriteMovies {
  static const String apiKey = ApiKey.apiKey;
  SessionId sessionIdObj = SessionId();
  List<Movie> favoriteMoviesList = [];
  SaveAndGetAccountID saveAndGetAccountID = SaveAndGetAccountID();
  SaveAndGetSessionID saveAndGetSessionID = SaveAndGetSessionID();

  Future<List<Movie>> getFavoriteMovies() async {
    final accountId = await saveAndGetAccountID.getAccountId();
    final sessionId = await saveAndGetSessionID.getSessionId();
    final String url =
        "https://api.themoviedb.org/3/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId";
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      favoriteMoviesList = List<Movie>.from(
          responseData['results'].map((e) => Movie.fromJson(e)));
      return favoriteMoviesList;
    } else {
      throw Exception("Failed to get Movies");
    }
  }
}
