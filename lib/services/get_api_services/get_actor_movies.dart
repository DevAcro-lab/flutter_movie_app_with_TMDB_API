import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../constants/api_key.dart';
import '../../model/movie.dart';
import 'package:http/http.dart' as http;

class GetMoviesByActorId {
  static const String apiKey = ApiKey.apiKey;
  List<Movie> actorMoviesList = [];

  Future<List<Movie>> getMoviesByActorId(int actorID) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_cast=$actorID";
    try {
      var response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        actorMoviesList = List<Movie>.from(
            decodedData['results'].map((e) => Movie.fromJson(e)));
        return actorMoviesList;
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
