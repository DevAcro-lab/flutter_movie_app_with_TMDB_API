import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/save_get_account_id_notifier.dart';
import 'package:movies_app/provider/save_get_session_id_notifier.dart';
import 'package:movies_app/services/get_api_services/get_movie_image.dart';
import 'package:provider/provider.dart';

import '../../provider/get_favorite_movies_notifier.dart';

class SavedMoviesScreen extends StatefulWidget {
  const SavedMoviesScreen({Key? key}) : super(key: key);

  @override
  State<SavedMoviesScreen> createState() => _SavedMoviesScreenState();
}

class _SavedMoviesScreenState extends State<SavedMoviesScreen> {
  GetFavoriteMoviesNotifier favoriteMoviesNotifier =
      GetFavoriteMoviesNotifier();
  GetMovieImage getMovieImage = GetMovieImage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetFavoriteMoviesNotifier>(context, listen: false)
          .fetchFavoriteMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GetFavoriteMoviesNotifier>(context);
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Favorite Movies",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () async {}, child: const Text("Delete")),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: s.height * 0.03),
                    child: Consumer<GetFavoriteMoviesNotifier>(
                      builder: (context, value, child) {
                        final favoriteMovies = value.favoriteMoviesList;
                        if (value.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (favoriteMovies.isEmpty) {
                          return const Text(
                              "You have no movies in your favorite list");
                        }
                        if (favoriteMovies.isNotEmpty) {
                          return ListView.builder(
                              itemCount: favoriteMovies.length,
                              itemBuilder: (context, index) {
                                final movie = favoriteMovies[index];
                                return Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.forgotPassColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              getMovieImage
                                                  .fetchImage(movie.posterPath),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: s.width * 0.03),
                                      SizedBox(
                                        height: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: s.height * 0.0035),
                                                SizedBox(
                                                  width: 170,
                                                  child: Text(
                                                    movie.title,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    softWrap: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: s.height * 0.007),
                                                const Text(
                                                  "Adventure, Animation",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: const Text(
                                                'Watch Now',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.more_vert_outlined),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
