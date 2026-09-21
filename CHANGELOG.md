# Changelog

## 1.0.6

- Readme updated.

## 1.0.5

- **Visual Previews & Screenshots Grid in README**:
  - Embedded 9 high-resolution screenshot previews in `README.md` covering the Main Selection Hub, Glassmorphism Home, Liquid Glass Home, Search Screens, Favorites ListViews, and Profile Screens.
  - Replaced HTML `<img>` tags with native Markdown `![Alt Text](path)` syntax for optimal rendering across pub.dev, GitHub, and IDE previews.
- **Top Padding Optimization**: Refined screen content top padding (`topPadding = 136.0px`) for edge-to-edge glass cards to clear the floating Glass AppBar.
- **Automated OIDC CI/CD Pipeline Verification**: Verified GitHub Actions workflow (`.github/workflows/ci_cd.yml`) with automated formatting, static analysis, 98 unit/widget tests, pub.dev OIDC publishing, and git release auto-tagging.

## 1.0.4

- **Modular Domain Directory Restructuring**:
  - Reorganized package architecture into clean, modular subdirectories under `lib/src/`:
    - `src/core/`: `glass_navigation_controller.dart`, `glass_scope.dart`, `glass_ui_contracts.dart`.
    - `src/models/`: `bottom_navigation_item.dart`, `glass_ui_style.dart`.
    - `src/components/`: `glass_app_bar.dart`, `glass_bottom_navigation_bar.dart`, `glass_button.dart`, `glass_card.dart`, `glass_container.dart`, `glass_navigation_card.dart`, `glass_switch.dart`, `glass_text_field.dart`.
    - `src/extensions/`: `glass_widget_extension.dart`.
    - `src/screens/`: `glass_morphism_ui.dart`, `liquid_glass_ui.dart`, `main_home_screen.dart`.
- **Pure Crystal Transparency**: Enhanced `LiquidGlassUI`, `LiquidGlassBottomNavBar`, `LiquidGlassCard`, `LiquidGlassContainer`, and `GlassAppBar.liquid` to support 100% crystal glass transparency (`Colors.transparent`).
- **Dynamic Tab-Driven AppBar Titles**: Added support for `titles: List<String>` allowing developers to pass custom titles per tab or let the AppBar dynamically switch between "Dashboard", "Search", "Favorites", and "Profile".
- **Dedicated Profile Screens**: Added `GlassmorphismProfileContent` and `LiquidGlassProfileContent` featuring static circular glass profile avatars, user info cards, account settings options, and logout buttons.
- **Dedicated Search Screens & Expanded ListViews**:
  - Added `GlassmorphismSearchContent` and `LiquidGlassSearchContent` with search fields and filter chips.
  - Expanded `_categories` Search ListViews and `_favorites` Favorites ListViews to 60 unique items each with smooth `BouncingScrollPhysics()`.
- **GitHub Actions Automated CI/CD Pipeline & Auto-Tagging**: Added `.github/workflows/ci_cd.yml` workflow for automated linting, formatting, 98 unit/widget test runs, pub.dev dry-run validation, automated publishing, and automatic git version tagging on success.

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
