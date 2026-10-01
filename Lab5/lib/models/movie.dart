class Trailer {
  const Trailer({required this.title, required this.duration});

  final String title;
  final String duration;
}

class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.year,
    required this.trailers,
  });

  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final int year;
  final List<Trailer> trailers;
}
