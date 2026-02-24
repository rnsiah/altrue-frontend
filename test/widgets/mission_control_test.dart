import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock Mission Control Dashboard widget for testing
/// Replace with actual implementation when available
class MockMissionControl extends StatelessWidget {
  const MockMissionControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Mission Control')),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('My Donations'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Following'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rewards'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  group('Mission Control Dashboard Tests', () {
    testWidgets('Dashboard displays all navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(const MockMissionControl());

      // Verify app bar title
      expect(find.text('Mission Control'), findsOneWidget);
      
      // Verify all menu items exist
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('My Donations'), findsOneWidget);
      expect(find.text('Following'), findsOneWidget);
      expect(find.text('Rewards'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Dashboard has correct icons', (WidgetTester tester) async {
      await tester.pumpWidget(const MockMissionControl());

      // Verify icons exist
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('Dashboard items are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MockMissionControl());

      // Tap on different items
      await tester.tap(find.text('Home'));
      await tester.pump();

      await tester.tap(find.text('My Donations'));
      await tester.pump();

      await tester.tap(find.text('Following'));
      await tester.pump();
    });

    testWidgets('Dashboard uses ListView for scrolling', (WidgetTester tester) async {
      await tester.pumpWidget(const MockMissionControl());

      // Verify ListView exists
      expect(find.byType(ListView), findsOneWidget);
      
      // Verify all ListTiles exist
      expect(find.byType(ListTile), findsNWidgets(5));
    });
  });
}
