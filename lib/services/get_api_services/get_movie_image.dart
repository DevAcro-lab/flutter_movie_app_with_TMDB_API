class GetMovieImage {
  String fetchImage(String imageUrl) {
    const baseImageUrl = 'https://image.tmdb.org/t/p/w500';
    return '$baseImageUrl$imageUrl';
  }
}
