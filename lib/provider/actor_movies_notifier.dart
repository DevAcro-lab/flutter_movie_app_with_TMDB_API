import 'package:flutter/cupertino.dart';
import 'package:movies_app/services/get_api_services/get_actor_movies.dart';

import '../model/movie.dart';

class ActorMoviesNotifier extends ChangeNotifier {
  bool isLoading = false;
  GetMoviesByActorId getMoviesByActorId = GetMoviesByActorId();
  List<Movie> actorMoviesList = [];

  Future<List<Movie>> fetchMoviesByActorId(int actorID) async {
    try {
      isLoading = true;
      notifyListeners();
      actorMoviesList = await getMoviesByActorId.getMoviesByActorId(actorID);
      print(actorMoviesList.toList().toString());
      isLoading = false;
      notifyListeners();
      return actorMoviesList;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("$e");
    }
  }
}
