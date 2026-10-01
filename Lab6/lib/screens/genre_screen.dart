import 'package:flutter/material.dart';
import 'package:lab6_responsive_ui/controllers/movie_browser_controller.dart';
import 'package:lab6_responsive_ui/data/movie_data.dart';
import 'package:lab6_responsive_ui/widgets/empty_state.dart';
import 'package:lab6_responsive_ui/widgets/genre_selector.dart';
import 'package:lab6_responsive_ui/widgets/movie_collection.dart';
import 'package:lab6_responsive_ui/widgets/movie_search_field.dart';
import 'package:lab6_responsive_ui/widgets/page_heading.dart';
import 'package:lab6_responsive_ui/widgets/results_toolbar.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MovieBrowserController _browserController = MovieBrowserController();

  @override
  void dispose() {
    _searchController.dispose();
    _browserController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    _browserController.setSearchQuery('');
  }

  void _clearFilters() {
    _searchController.clear();
    _browserController.clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth < 600 ? 16.0 : 28.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                0,
              ),
              child: AnimatedBuilder(
                animation: _browserController,
                builder: (context, _) {
                  final movies = _browserController.visibleMovies;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const PageHeading(),
                      const SizedBox(height: 18),
                      MovieSearchField(
                        controller: _searchController,
                        query: _browserController.searchQuery,
                        onChanged: _browserController.setSearchQuery,
                        onClear: _clearSearch,
                      ),
                      const SizedBox(height: 16),
                      GenreSelector(
                        genres: movieGenres,
                        selectedGenres: _browserController.selectedGenres,
                        onGenreSelected: _browserController.toggleGenre,
                      ),
                      const SizedBox(height: 14),
                      ResultsToolbar(
                        movieCount: movies.length,
                        selectedSort: _browserController.selectedSort,
                        showClearButton: _browserController.hasFilters,
                        onSortChanged: (sort) {
                          if (sort != null) {
                            _browserController.setSort(sort);
                          }
                        },
                        onClear: _clearFilters,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: movies.isEmpty
                            ? const EmptyState()
                            : MovieCollection(movies: movies),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
