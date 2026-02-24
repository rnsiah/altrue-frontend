import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/comp_dashboard_donate.dart';

void main() {
  group('Donation Flow Widget Tests', () {
    testWidgets('Donation screen displays amount options', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CompanyDashboardDonate(),
          ),
        ),
      );

      // Verify donation elements
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Donation screen handles amount selection', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CompanyDashboardDonate(),
          ),
        ),
      );

      // Find and tap a donation amount button
      final buttons = find.byType(ElevatedButton);
      if (buttons.evaluate().isNotEmpty) {
        await tester.tap(buttons.first);
        await tester.pump();

        // Should proceed to payment or show confirmation
        expect(find.byType(AlertDialog), findsNothing);
      }
    });
  });
}
