import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/actor_movies_notifier.dart';
import 'package:movies_app/provider/get_favorite_movies_notifier.dart';
import 'package:movies_app/provider/genres_notifier.dart';
import 'package:movies_app/provider/latest_movies_notifier.dart';
import 'package:movies_app/provider/movie_characters_notifier.dart';
import 'package:movies_app/provider/movie_details_notifier.dart';
import 'package:movies_app/provider/movies_by_genres_notifier.dart';
import 'package:movies_app/provider/popular_movies_notifier.dart';
import 'package:movies_app/provider/post_favorite_movies_notifier.dart';
import 'package:movies_app/provider/recommended_movies_notifier.dart';
import 'package:movies_app/provider/save_get_account_id_notifier.dart';
import 'package:movies_app/provider/searched_movies_notifier.dart';
import 'package:movies_app/provider/top_rated_movies_notifier.dart';
import 'package:movies_app/provider/user_preferences_notifier.dart';
import 'package:movies_app/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ActorMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenresNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => LatestMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieCharactersNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieDetailsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MoviesByGenresNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PopularMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecommendedMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopRatedMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaveAndGetAccountID(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserPreferences(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetFavoriteMoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostFavoriteMoviesNotifier(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.scaffoldBacColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
