import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/provider/get_favorite_movies_notifier.dart';
import 'package:movies_app/provider/save_get_session_id_notifier.dart';

class PostFavoriteMovie {
  static const String apikey = ApiKey.apiKey;
  SaveAndGetSessionID saveAndGetSessionID = SaveAndGetSessionID();

  Future<void> postFavoriteMovies(context, int movieId) async {
    final sessionId = await saveAndGetSessionID.getSessionId();
    final url =
        "https://api.themoviedb.org/3/account/20408082/favorite?api_key=$apikey&session_id=$sessionId";
    final response = await http.post(Uri.parse(url), body: {
      'media_type': 'movie',
      'movie_id': movieId.toString(),
      'favorite': "true",
    });
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (responseData['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully Added a Movie to Favorite Movies"),
          ),
        );
      } else {
        throw "Failed to add movie to Favorites list";
      }
    } else {
      print("${response.statusCode}");
    }
  }
}
