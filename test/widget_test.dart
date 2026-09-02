import 'package:flutter_test/flutter_test.dart';
import 'glass_morphism_ui_test.dart' as glass_morphism_tests;
import 'liquid_glass_ui_test.dart' as liquid_glass_tests;
import 'main_screen_test.dart' as main_screen_tests;
import 'unit_and_painter_test.dart' as unit_and_painter_tests;

void main() {
  group('All Glass UI Widget & Unit Tests', () {
    main_screen_tests.main();
    glass_morphism_tests.main();
    liquid_glass_tests.main();
    unit_and_painter_tests.main();
  });
}
