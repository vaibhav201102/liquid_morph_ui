import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app_test.dart' as app_tests;
import 'gesture_and_stress_test.dart' as gesture_tests;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Complete Master Integration Test Suite', () {
    app_tests.runAppTests();
    gesture_tests.runGestureAndStressTests();
  });
}
