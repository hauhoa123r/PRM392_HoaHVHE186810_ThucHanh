import 'package:flutter/material.dart';
import 'package:lab6_responsive_ui/core/theme/app_theme.dart';
import 'package:lab6_responsive_ui/screens/genre_screen.dart';

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find a Movie',
      theme: AppTheme.light,
      home: const GenreScreen(),
    );
  }
}
