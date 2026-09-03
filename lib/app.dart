import 'package:flutter/material.dart';
import 'package:glass_bottom_bar_ui/main_home_screen.dart';

export 'package:glass_bottom_bar_ui/main_home_screen.dart';

/// Root application widget configuring app theme and initial route.
class MyApp extends StatelessWidget {
  static const Color _seedColor = Color(0xFF6A11CB);

  /// Creates [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}
