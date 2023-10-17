import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/searched_movies_notifier.dart';
import 'package:movies_app/view/home/home_screen.dart';
import 'package:movies_app/view/movie_details/movie_details_screen.dart';
import 'package:provider/provider.dart';
import '../../services/get_api_services/get_movie_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  SearchMoviesNotifier searchMovies = SearchMoviesNotifier();
  GetMovieImage getMovieImage = GetMovieImage();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search by title, genre, actor",
                        hintStyle: const TextStyle(
                          color: AppColors.forgotPassColor,
                        ),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 14),
                        fillColor: AppColors.forgotPassColor.withOpacity(0.3),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.forgotPassColor,
                            size: 18,
                          ),
                          onPressed: () {
                            searchController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            query = searchController.text;
                          });
                          Provider.of<SearchMoviesNotifier>(context,
                                  listen: false)
                              .clearSearchList();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          color: AppColors.primaryColor,
                          child:
                              const Text("Search", textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: searchMovies.fetchSearchedMovies(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final movieData = snapshot.data;
                    return GridView.builder(
                        itemCount: searchMovies.searchMoviesList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.2 / 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return MovieContainer(
                              s: s,
                              onPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                        movieID: movieData![index].id)));
                              },
                              imageUrl: getMovieImage.fetchImage(
                                  snapshot.data![index].posterPath));
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text("Sorry, Couldn't find the matching"));
                  } else {
                    return const CircularProgressIndicator();
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
