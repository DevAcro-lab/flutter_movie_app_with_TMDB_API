import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_details.dart';
import 'package:movies_app/provider/movie_characters_notifier.dart';
import 'package:movies_app/provider/movie_details_notifier.dart';
import 'package:movies_app/provider/post_favorite_movies_notifier.dart';
import 'package:movies_app/provider/recommended_movies_notifier.dart';
import 'package:movies_app/view/movies_by_actor_id/movies_by_actor_id_screen.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../constants/colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({Key? key, required this.movieID}) : super(key: key);
  int movieID;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  MovieDetailsNotifier movieDetailsNotifier = MovieDetailsNotifier();
  String buildPosterUrl(String posterPath) {
    const baseImageUrl = 'https://image.tmdb.org/t/p/w500';
    return '$baseImageUrl$posterPath';
  }

  TabController? tabController;
  MovieCharactersNotifier movieCharactersNotifier = MovieCharactersNotifier();
  RecommendedMoviesNotifier recommendedMoviesNotifier =
      RecommendedMoviesNotifier();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  List<String> movieCastProfilePictures = [];
  List<String> movieCastNames = [];
  List<int> castID = [];

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: movieDetailsNotifier.fetchMovieDetails(widget.movieID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movieDetails = snapshot.data;
            final genresList = movieDetails!.genres;
            var genresText;
            if (genresList != null) {
              final genresNames = genresList.map((e) => e.name).toList();
              genresText = genresNames.join(", ");
            }
            final productionCompanies = movieDetails.productionCompanies;
            var productionCompanyText;
            if (productionCompanies != null) {
              final productionCompaniesNames =
                  productionCompanies.map((e) => e.name).toList();
              productionCompanyText = productionCompaniesNames.join(", ");
            }

            final productionContries = movieDetails.productionCountries;
            var productionContriesText;
            if (productionContries != null) {
              final productionCountriesNames =
                  productionContries.map((e) => e.name).toList();
              productionContriesText = productionCountriesNames.join(", ");
            }

            return SingleChildScrollView(
              child: SizedBox(
                height: s.height,
                child: Column(
                  children: [
                    Container(
                      height: s.height * 0.34,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              buildPosterUrl(
                                movieDetails.backdropPath.toString(),
                              ),
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 35),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.forgotPassColor
                                      .withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 22,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Consumer<PostFavoriteMoviesNotifier>(
                              builder: (context, provider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.addMovieToFavList(
                                        context, movieDetails.id!);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.forgotPassColor
                                          .withOpacity(0.5),
                                    ),
                                    child: const Icon(
                                      Icons.save_outlined,
                                      size: 22,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: s.width * 0.04),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.forgotPassColor
                                      .withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.share_outlined,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: s.height * 0.03),
                          Text(
                            movieDetails.originalTitle!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: s.height * 0.005),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                movieDetails.releaseDate!.substring(0, 4),
                                softWrap: true,
                                style: TextStyle(
                                  color: AppColors.whiteWithOpacity,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                " • $genresText",
                                softWrap: true,
                                style: TextStyle(
                                  color: AppColors.whiteWithOpacity,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                " • ${movieDetails.runtime} mins",
                                softWrap: true,
                                style: TextStyle(
                                  color: AppColors.whiteWithOpacity,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: s.height * 0.027),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: s.width * 0.43,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.play_arrow),
                                    SizedBox(width: s.width * 0.01),
                                    const Text("Play"),
                                  ],
                                ),
                              ),
                              Container(
                                width: s.width * 0.43,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.forgotPassColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_downward_outlined,
                                    ),
                                    SizedBox(width: s.width * 0.01),
                                    const Text("Download"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: s.height * 0.027),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: ReadMoreText(
                              movieDetails.overview!,
                              trimLines: 3,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: ' Show less',
                              moreStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              lessStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              colorClickableText: Colors.white,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.whiteWithOpacity,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: s.height * 0.025),
                    TabBar(
                      controller: tabController,
                      indicatorColor: AppColors.primaryColor,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.forgotPassColor,
                      tabs: const [
                        Tab(
                          text: 'Similar',
                          height: 35,
                        ),
                        Tab(
                          text: 'About',
                          height: 35,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          recommendedWidget(),
                          aboutWidget(s, genresText, productionCompanyText,
                              movieDetails, productionContriesText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("SnapShot error: ERRRRORRRR${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding recommendedWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: FutureBuilder(
          future:
              recommendedMoviesNotifier.fetchRecommendedMovies(widget.movieID),
          builder: (context, snapshot) {
            var recommendedMovieData = snapshot.data;
            if (snapshot.hasData) {
              return recommendedMovieData!.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        'No Recommendations for this movie',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.builder(
                      itemCount: recommendedMovieData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.1 / 3,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    movieID: recommendedMovieData[index].id)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(buildPosterUrl(
                                      recommendedMovieData[index].posterPath)),
                                )),
                          ),
                        );
                      });
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Padding aboutWidget(Size s, genresText, productionCompanyText,
      MovieDetails movieDetails, productionContriesText) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Genre",
                      style: TextStyle(
                        color: AppColors.forgotPassColor,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: s.height * 0.004),
                    SizedBox(
                      width: s.width * 0.4,
                      child: Text(
                        genresText,
                        style: const TextStyle(
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: s.height * 0.02),
                    const Text(
                      "Production companies",
                      style: TextStyle(
                        color: AppColors.forgotPassColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: s.height * 0.004),
                    SizedBox(
                      width: s.width * 0.4,
                      child: Text(
                        productionCompanyText,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: s.width * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Language",
                      style: TextStyle(
                        color: AppColors.forgotPassColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: s.height * 0.004),
                    Text(
                      movieDetails.originalLanguage!,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: s.height * 0.02),
                    const Text(
                      "Production countries",
                      style: TextStyle(
                        color: AppColors.forgotPassColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: s.height * 0.004),
                    SizedBox(
                      width: s.width * 0.4,
                      child: Text(
                        productionContriesText,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: s.height * 0.02),
            const Text(
              "Actors and Actresses",
              style: TextStyle(
                color: AppColors.forgotPassColor,
                fontSize: 12,
              ),
            ),
            SizedBox(height: s.height * 0.015),
            SizedBox(
              height: s.height * 0.17,
              child: FutureBuilder(
                future: movieCharactersNotifier
                    .fetchMovieCharacters(widget.movieID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var movieCharacterData = snapshot.data;
                    final movieCast = movieCharacterData!.cast;

                    if (movieCast != null) {
                      movieCastProfilePictures =
                          movieCast.map((e) => e.profilePath ?? "").toList();
                      movieCastNames =
                          movieCast.map((e) => e.name ?? '').toList();
                    }
                    if (movieCast != null) {
                      castID = movieCast.map((e) => e.id!).toList();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieCastProfilePictures.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          final profilePath = movieCastProfilePictures[index];
                          final imageUrl =
                              "https://image.tmdb.org/t/p/w500$profilePath";
                          final movieCastNameText = movieCastNames[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MoviesByActorIDScreen(
                                    actorID: castID[index],
                                    castName: movieCastNameText,
                                  ),
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 5,
                                ),
                                width: s.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageUrl),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    movieCastNameText,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Something is fishy");
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Something went wrong. ${snapshot.error}");
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
