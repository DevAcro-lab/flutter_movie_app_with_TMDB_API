import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/actor_movies_notifier.dart';
import 'package:movies_app/view/home/home_screen.dart';
import 'package:movies_app/view/movie_details/movie_details_screen.dart';
import '../../services/get_api_services/get_movie_image.dart';

class MoviesByActorIDScreen extends StatelessWidget {
  int actorID;
  String castName;
  MoviesByActorIDScreen(
      {Key? key, required this.actorID, required this.castName})
      : super(key: key);

  ActorMoviesNotifier actorMoviesNotifier = ActorMoviesNotifier();
  GetMovieImage getMovieImage = GetMovieImage();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(castName),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.scaffoldBacColor,
      ),
      body: FutureBuilder(
        future: actorMoviesNotifier.fetchMoviesByActorId(actorID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movieData = snapshot.data;
            return GridView.builder(
                itemCount: movieData!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.2 / 3,
                ),
                itemBuilder: (context, index) {
                  final imageUrl = movieData[index].posterPath;
                  return movieData == []
                      ? const Center(
                          child: Text(
                              "Sorry, Couldn't find Movies for this Actor"),
                        )
                      : MovieContainer(
                          s: s,
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    movieID: movieData[index].id)));
                          },
                          imageUrl: getMovieImage.fetchImage(imageUrl));
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
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
}
