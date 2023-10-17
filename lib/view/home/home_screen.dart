// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/provider/genres_notifier.dart';
import 'package:movies_app/provider/latest_movies_notifier.dart';
import 'package:movies_app/provider/popular_movies_notifier.dart';
import 'package:movies_app/provider/top_rated_movies_notifier.dart';
import 'package:movies_app/view/categorized_movies/categorized_movies_screen.dart';
import 'package:movies_app/view/movie_details/movie_details_screen.dart';
import '../../constants/widgets/carousel_slider.dart';
import '../../services/get_api_services/get_movie_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PopularMoviesNotifier popularMoviesNotifier = PopularMoviesNotifier();
  LatestMoviesNotifier discoverMoviesNotifier = LatestMoviesNotifier();
  TopRatedMoviesNotifier topRatedMoviesNotifier = TopRatedMoviesNotifier();
  GenresNotifier genresNotifier = GenresNotifier();
  GetMovieImage getMovieImage = GetMovieImage();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CarouselImageSlider(),
            SizedBox(height: s.height * 0.017),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: s.height * 0.015),
                  SizedBox(
                      height: s.height * 0.04,
                      child: FutureBuilder(
                        future: genresNotifier.fetchGenres(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return CategoryContainer(
                                    title:
                                        snapshot.data![index].name.toString(),
                                    onPress: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  CategorizedMovies(
                                                    categoryName: snapshot
                                                        .data![index].name
                                                        .toString(),
                                                    genresId: snapshot
                                                        .data![index].id!,
                                                  )));
                                    },
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return const Text("Something wrong");
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )),
                  SizedBox(height: s.height * 0.017),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(height: s.height * 0.015),
                  SizedBox(
                    height: s.height * 0.22,
                    child: FutureBuilder<List<Movie>>(
                      future: popularMoviesNotifier.getPopularMovies(),
                      builder: (context, snapshot) {
                        var movieData = snapshot.data;
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: movieData!.length,
                            itemBuilder: (context, index) {
                              final movie = movieData[index];
                              return MovieContainer(
                                s: s,
                                imageUrl:
                                    getMovieImage.fetchImage(movie.posterPath),
                                onPress: () {
                                  print(movie.id);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                            movieID: movie.id,
                                          )));
                                },
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          );
                        } else if (snapshot.hasError) {
                          print("ERROR: ${snapshot.error}");
                          return const Center(
                              child: Text('Something went Wrong'));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  SizedBox(height: s.height * 0.017),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Movies',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(height: s.height * 0.015),
                  SizedBox(
                    height: s.height * 0.22,
                    child: FutureBuilder(
                      future: discoverMoviesNotifier.getDiscoverMovies(),
                      builder: (context, snapshot) {
                        var movieData = snapshot.data;
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: movieData!.length,
                            itemBuilder: (context, index) {
                              final movie = movieData[index];
                              return MovieContainer(
                                s: s,
                                imageUrl:
                                    getMovieImage.fetchImage(movie.posterPath),
                                onPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailsScreen(movieID: movie.id),
                                    ),
                                  );
                                },
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: s.height * 0.017),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(height: s.height * 0.015),
                  SizedBox(
                    height: s.height * 0.22,
                    child: FutureBuilder(
                        future: topRatedMoviesNotifier.getTopRatedMovies(),
                        builder: (context, snapshot) {
                          var movieData = snapshot.data;
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: movieData!.length,
                              itemBuilder: (context, index) {
                                final movie = movieData[index];
                                return MovieContainer(
                                  s: s,
                                  imageUrl: getMovieImage
                                      .fetchImage(movie.posterPath),
                                  onPress: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                                movieID: movie.id),
                                      ),
                                    );
                                  },
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieContainer extends StatelessWidget {
  MovieContainer({
    super.key,
    required this.s,
    required this.onPress,
    required this.imageUrl,
  });

  final Size s;
  final String imageUrl;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          width: s.width * 0.27,
          // height: s.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String title;
  VoidCallback onPress;
  CategoryContainer({
    super.key,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primaryColor,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
