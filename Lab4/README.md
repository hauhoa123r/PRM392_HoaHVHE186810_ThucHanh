# Lab 4 - Flutter UI Fundamentals

This project contains a launcher and five runnable exercises:

1. Core widgets: `Text`, `Icon`, `Image.network`, `Card`, and `ListTile`.
2. Input widgets: `Slider`, `Switch`, radio choices, and `DatePicker`.
3. Layout composition: `Column`, `Row`, `Padding`, `SizedBox`, and
   `ListView.builder`.
4. App structure: `Scaffold`, `AppBar`, body, `FloatingActionButton`, and a
   light/dark `ThemeData` toggle.
5. Working fixes for common UI errors.

## Run

```shell
flutter pub get
flutter run
```

## Exercise 5 fixes

- **ListView inside Column:** a `ListView` needs a finite vertical constraint.
  Wrapping it in `Expanded` gives it the remaining height and prevents the
  unbounded-height error.
- **Overflow on small screens:** `SingleChildScrollView` lets content scroll
  instead of producing a yellow/black overflow warning.
- **State not updating:** values that affect the UI are changed inside
  `setState()`, which asks Flutter to rebuild the widget.
- **DatePicker context error:** `showDatePicker` is called from a button callback
  using the mounted State's `BuildContext`; the result is applied only after
  checking `mounted`.

Run `flutter test` to execute the widget tests and `flutter analyze` to check
the source code.
