# Movie Night

A two-screen Flutter movie app created for Lab 5. It demonstrates passing a
`Movie` object with `Navigator.push` and `MaterialPageRoute`, responsive
scrolling layouts, Hero animation, and local UI state.

## Features

- Searchable movie list with posters, ratings, years, and genres
- Detail page with a gradient Hero banner, genre chips, and overview
- Favorite state that remains visible after returning to the home screen
- Interactive rating sheet, share feedback, and trailer rows
- Loading and error fallbacks for network images
- Widget tests for filtering, navigation, and favorite state

## Run the app

```sh
flutter pub get
flutter run
```

The sample posters use HTTPS image URLs, so the device or emulator needs an
internet connection. If an image is unavailable, the UI displays a movie icon
instead.

## Verify

```sh
flutter analyze
flutter test
```

## Main source files

- `lib/models/movie.dart` - movie and trailer models
- `lib/data/sample_movies.dart` - static sample data
- `lib/screens/home_screen.dart` - searchable movie list
- `lib/screens/movie_detail_screen.dart` - selected movie details and actions
- `lib/widgets/network_poster.dart` - reusable network image with fallbacks
