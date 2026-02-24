# Altrue Flutter Testing Guide

## Test Structure

```
test/
├── widget_test.dart              # Main app widget test
├── widgets/                      # Widget tests
│   ├── login_form_test.dart      # Login/authentication
│   ├── donation_flow_test.dart   # Donation screens
│   └── mission_control_test.dart # Dashboard
└── integration/                  # Integration tests
    └── api_integration_test.dart # API communication
```

## Running Tests

```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific file
flutter test test/widgets/login_form_test.dart

# Integration tests
flutter test integration_test/
```

## Adding New Tests

1. Create test file in appropriate directory
2. Import required packages
3. Use `testWidgets()` for widget tests
4. Use `group()` to organize related tests
5. Follow AAA pattern: Arrange, Act, Assert

## Mocking

Use `mockito` or `http/testing.dart` for mocking:

```dart
import 'package:http/testing.dart';

final mockClient = MockClient((request) async {
  return http.Response(jsonEncode({'key': 'token'}), 200);
});
```

## Coverage

Target: 60%+ widget coverage

Generate report:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```
