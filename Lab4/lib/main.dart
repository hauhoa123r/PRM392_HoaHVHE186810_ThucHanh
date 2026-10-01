import 'package:flutter/material.dart';

import 'screens/app_structure_demo.dart';
import 'screens/common_ui_fixes_demo.dart';
import 'screens/core_widgets_demo.dart';
import 'screens/input_controls_demo.dart';
import 'screens/layout_demo.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget for the complete Lab 4 application.
///
/// It owns the dark-mode state so Exercise 4 can update the theme for the
/// entire app instead of changing only one screen.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _setDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LabHomePage(
        isDarkMode: _isDarkMode,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
    );
  }
}

/// Launcher screen that gives each exercise its own runnable page.
class LabHomePage extends StatelessWidget {
  const LabHomePage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    final exercises = <_ExerciseDestination>[
      const _ExerciseDestination(
        title: 'Exercise 1 - Core Widgets Demo',
        icon: Icons.widgets_outlined,
        page: CoreWidgetsDemo(),
      ),
      const _ExerciseDestination(
        title: 'Exercise 2 - Input Controls Demo',
        icon: Icons.tune,
        page: InputControlsDemo(),
      ),
      const _ExerciseDestination(
        title: 'Exercise 3 - Layout Demo',
        icon: Icons.view_agenda_outlined,
        page: LayoutDemo(),
      ),
      _ExerciseDestination(
        title: 'Exercise 4 - App Structure & Theme',
        icon: Icons.dark_mode_outlined,
        page: AppStructureDemo(
          isDarkMode: isDarkMode,
          onDarkModeChanged: onDarkModeChanged,
        ),
      ),
      const _ExerciseDestination(
        title: 'Exercise 5 - Common UI Fixes',
        icon: Icons.build_outlined,
        page: CommonUiFixesDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 - Flutter UI Fundamentals')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: Icon(exercise.icon),
              title: Text(exercise.title),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => exercise.page));
              },
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseDestination {
  const _ExerciseDestination({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}
