// Main entry point for all widget tests.
//
// This file imports and runs all widget tests in the test/ directory.
// Tests are organized by feature:
// - Authentication tests
// - Dashboard tests  
// - Donation flow tests

import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'widgets/signup_screen_test.dart' as signup_tests;
import 'widgets/dashboard_test.dart' as dashboard_tests;
import 'widgets/donation_flow_test.dart' as donation_tests;

void main() {
  // Run all widget test suites
  group('Altrue App Widget Tests', () {
    signup_tests.main();
    dashboard_tests.main();
    donation_tests.main();
  });
}
