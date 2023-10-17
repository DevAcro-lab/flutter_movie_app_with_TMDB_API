import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/movies_by_genres_notifier.dart';
import 'package:movies_app/view/home/home_screen.dart';
import 'package:movies_app/view/movie_details/movie_details_screen.dart';

import '../../services/get_api_services/get_movie_image.dart';

class CategorizedMovies extends StatelessWidget {
  final String categoryName;
  final int genresId;
  const CategorizedMovies(
      {Key? key, required this.categoryName, required this.genresId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetMovieImage getMovieImage = GetMovieImage();
    MoviesByGenresNotifier moviesByGenresNotifier = MoviesByGenresNotifier();
    String buildPosterUrl(String posterPath) {
      const baseImageUrl = 'https://image.tmdb.org/t/p/w500';
      return '$baseImageUrl$posterPath';
    }

    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.scaffoldBacColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: s.height * 0.02),
            Expanded(
              child: FutureBuilder(
                future: moviesByGenresNotifier.fetchMoviesByGenres(genresId),
                builder: (context, snapshot) {
                  var movieData = snapshot.data;
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                          itemCount: movieData!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2 / 3,
                          ),
                          itemBuilder: (context, index) {
                            return MovieContainer(
                                s: s,
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                          movieID: movieData[index].id)));
                                },
                                imageUrl: getMovieImage
                                    .fetchImage(movieData[index].posterPath));
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
