import '../models/movie.dart';

const sampleMovies = <Movie>[
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge '
        'against the conspirators who destroyed his family. Facing a choice '
        'between love and the fate of the universe, he tries to prevent a '
        'terrible future only he can foresee.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    year: 2024,
    trailers: [
      Trailer(title: 'Official Trailer #1', duration: '2:40'),
      Trailer(title: 'Official Trailer #2', duration: '2:41'),
      Trailer(title: 'IMAX Sneak Peek', duration: '5:12'),
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
    overview:
        'The multiverse gets messy when Wade Wilson teams up with Wolverine '
        'for a not-so-family-friendly mission. Their reluctant partnership '
        'may be the only thing standing between their world and disaster.',
    genres: ['Action', 'Comedy', 'Sci-Fi'],
    rating: 8.3,
    year: 2024,
    trailers: [
      Trailer(title: 'Red Band Trailer', duration: '2:39'),
      Trailer(title: 'Final Trailer', duration: '2:00'),
      Trailer(title: 'Behind the Scenes', duration: '4:18'),
    ],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    backdropUrl:
        'https://image.tmdb.org/t/p/w1280/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg',
    overview:
        'Riley enters her teenage years and Headquarters is suddenly shaken by '
        'the arrival of new emotions. Joy, Sadness, Anger, Fear, and Disgust '
        'must learn how to make room for Anxiety and her ambitious plans.',
    genres: ['Animation', 'Family', 'Comedy'],
    rating: 7.7,
    year: 2024,
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:25'),
      Trailer(title: 'Introducing Anxiety', duration: '1:12'),
    ],
  ),
];
