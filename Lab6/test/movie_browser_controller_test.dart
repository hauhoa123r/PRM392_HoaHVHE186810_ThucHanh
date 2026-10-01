import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_responsive_ui/controllers/movie_browser_controller.dart';
import 'package:lab6_responsive_ui/models/movie_sort.dart';

void main() {
  group('MovieBrowserController', () {
    late MovieBrowserController controller;

    setUp(() {
      controller = MovieBrowserController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('filters by search query without considering case', () {
      controller.setSearchQuery('INCEPTION');

      expect(controller.visibleMovies.map((movie) => movie.title), <String>[
        'Inception',
      ]);
    });

    test('matches any selected genre', () {
      controller.toggleGenre('Animation');

      expect(controller.visibleMovies, hasLength(2));
      expect(
        controller.visibleMovies.every(
          (movie) => movie.genres.contains('Animation'),
        ),
        isTrue,
      );
    });

    test('sorts by rating from highest to lowest', () {
      controller.setSort(MovieSort.rating);

      expect(controller.visibleMovies.first.title, 'Inception');
      expect(controller.visibleMovies.last.title, 'Knives Out');
    });

    test('clears search and genre filters', () {
      controller
        ..setSearchQuery('movie')
        ..toggleGenre('Drama')
        ..clearFilters();

      expect(controller.searchQuery, isEmpty);
      expect(controller.selectedGenres, isEmpty);
      expect(controller.visibleMovies, hasLength(8));
    });
  });
}
