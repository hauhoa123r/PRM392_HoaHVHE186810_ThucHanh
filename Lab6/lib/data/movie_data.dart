import 'package:lab6_responsive_ui/models/movie.dart';

const List<Movie> allMovies = <Movie>[
  Movie(
    title: 'Inception',
    year: 2010,
    genres: <String>['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/inception/480/720',
    rating: 8.8,
  ),
  Movie(
    title: 'The Grand Budapest Hotel',
    year: 2014,
    genres: <String>['Comedy', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/budapest/480/720',
    rating: 8.1,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: <String>['Adventure', 'Drama', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/seed/interstellar/480/720',
    rating: 8.7,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: <String>['Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/parasite/480/720',
    rating: 8.5,
  ),
  Movie(
    title: 'Spider-Man: Into the Spider-Verse',
    year: 2018,
    genres: <String>['Action', 'Animation', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/spiderverse/480/720',
    rating: 8.4,
  ),
  Movie(
    title: 'La La Land',
    year: 2016,
    genres: <String>['Drama', 'Romance'],
    posterUrl: 'https://picsum.photos/seed/lalaland/480/720',
    rating: 8.0,
  ),
  Movie(
    title: 'Knives Out',
    year: 2019,
    genres: <String>['Comedy', 'Mystery', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/knivesout/480/720',
    rating: 7.9,
  ),
  Movie(
    title: 'The Wild Robot',
    year: 2024,
    genres: <String>['Animation', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/wildrobot/480/720',
    rating: 8.2,
  ),
];

const List<String> movieGenres = <String>[
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Drama',
  'Mystery',
  'Romance',
  'Sci-Fi',
  'Thriller',
];
