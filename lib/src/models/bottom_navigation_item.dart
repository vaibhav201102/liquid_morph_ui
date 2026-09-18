import 'package:flutter/material.dart';

/// Model class representing configuration data for a bottom navigation item.
class BottomNavigationItem {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;
  final int index;

  const BottomNavigationItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.index,
  });
}
