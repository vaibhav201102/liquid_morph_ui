# Changelog

## 1.0.4

- **Pure Crystal Transparency**: Enhanced `LiquidGlassUI`, `LiquidGlassBottomNavBar`, `LiquidGlassCard`, `LiquidGlassContainer`, and `GlassAppBar.liquid` to support 100% crystal glass transparency (`Colors.transparent`).
- **Dynamic Tab-Driven AppBar Titles**: Added support for `titles: List<String>` allowing developers to pass custom titles per tab or let the AppBar dynamically switch between "Dashboard", "Search", "Favorites", and "Profile".
- **Expanded Component Suites & ListViews**:
  - Embedded 60 unique items in `_categories` Search ListViews and `_favorites` Favorites ListViews with smooth `BouncingScrollPhysics()`.
  - Added dedicated `GlassmorphismProfileContent` and `LiquidGlassProfileContent` screens featuring static circular glass profile avatars, user info cards, account settings options, and logout buttons.
- **GitHub Actions Automated CI/CD Pipeline**: Added `.github/workflows/ci_cd.yml` workflow for automated linting, formatting, unit test verification, pub.dev dry-run validation, and automated publishing to `pub.dev`.

## 1.0.3

- Updated `homepage`, `repository`, and `issue_tracker` URLs to `https://github.com/vaibhav201102/liquid_morph_ui`.
- Passed all pub.dev package validation and link health checks.

## 1.0.2

- Updated OSI-approved MIT License template format.
- Fixed back button key resolution in `GlassAppBar` for both Glassmorphism and Liquid Glass styles.
- Renamed package to `liquid_morph_ui`.
- All 56 unit, widget, and integration tests passed.

## 1.0.1

- Added standalone customizable `GlassAppBar` and `GlassAppBar.liquid` widgets.
- Added `leftButtons` and `rightButtons` properties for outside AppBar customization in `GlassmorphismUI` and `LiquidGlassUI`.
- Updated example app with live previews of custom AppBars and standalone GlassAppBar.

## 1.0.0

- Initial release.
