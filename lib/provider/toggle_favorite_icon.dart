// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:movies_app/provider/get_favorite_movies_notifier.dart';
// import 'package:movies_app/provider/post_favorite_movies_notifier.dart';
// import 'package:provider/provider.dart';
//
// import '../model/movie.dart';
//
// class ToggleFavoriteMovieIcon extends ChangeNotifier {
//   GetFavoriteMoviesNotifier getFavoriteMoviesNotifier;
//   PostFavoriteMoviesNotifier postFavoriteMoviesNotifier;
//
//   ToggleFavoriteMovieIcon(
//       {required this.getFavoriteMoviesNotifier,
//       required this.postFavoriteMoviesNotifier});
//   List<Movie> favMovies = [];
//
//   Future<void> toggleFavIcon(context, int movieId) async {
//     favMovies = getFavoriteMoviesNotifier.favoriteMoviesList;
//     final isExist = favMovies.any((movie) => movie.id == movieId);
//     if (isExist) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Already added")));
//     } else {
//       postFavoriteMoviesNotifier.addMovieToFavList(context, movieId);
//       Provider.of<GetFavoriteMoviesNotifier>(context, listen: false)
//           .fetchFavoriteMovies();
//       notifyListeners();
//     }
//     print("Fav movies: $favMovies");
//   }
//
//   bool isExist(int movieId) {
//     final isExist = favMovies.any((movie) => movie.id == movieId);
//     return isExist;
//   }
// }
