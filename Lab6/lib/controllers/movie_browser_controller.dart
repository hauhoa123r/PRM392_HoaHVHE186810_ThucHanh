import 'package:flutter/foundation.dart';
import 'package:lab6_responsive_ui/data/movie_data.dart';
import 'package:lab6_responsive_ui/models/movie.dart';
import 'package:lab6_responsive_ui/models/movie_sort.dart';

class MovieBrowserController extends ChangeNotifier {
  MovieBrowserController([this._movies = allMovies]);

  final List<Movie> _movies;
  final Set<String> _selectedGenres = <String>{};

  String _searchQuery = '';
  MovieSort _selectedSort = MovieSort.az;

  String get searchQuery => _searchQuery;
  MovieSort get selectedSort => _selectedSort;
  Set<String> get selectedGenres => Set<String>.unmodifiable(_selectedGenres);
  bool get hasFilters => _searchQuery.isNotEmpty || _selectedGenres.isNotEmpty;

  List<Movie> get visibleMovies {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final movies = _movies.where((movie) {
      final matchesSearch =
          normalizedQuery.isEmpty ||
          movie.title.toLowerCase().contains(normalizedQuery);
      final matchesGenre =
          _selectedGenres.isEmpty || movie.genres.any(_selectedGenres.contains);
      return matchesSearch && matchesGenre;
    }).toList();

    switch (_selectedSort) {
      case MovieSort.az:
        movies.sort((a, b) => a.title.compareTo(b.title));
      case MovieSort.za:
        movies.sort((a, b) => b.title.compareTo(a.title));
      case MovieSort.year:
        movies.sort((a, b) => b.year.compareTo(a.year));
      case MovieSort.rating:
        movies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return movies;
  }

  void setSearchQuery(String value) {
    if (_searchQuery == value) return;
    _searchQuery = value;
    notifyListeners();
  }

  void toggleGenre(String genre) {
    if (!_selectedGenres.add(genre)) {
      _selectedGenres.remove(genre);
    }
    notifyListeners();
  }

  void setSort(MovieSort sort) {
    if (_selectedSort == sort) return;
    _selectedSort = sort;
    notifyListeners();
  }

  void clearFilters() {
    if (!hasFilters) return;
    _searchQuery = '';
    _selectedGenres.clear();
    notifyListeners();
  }
}
