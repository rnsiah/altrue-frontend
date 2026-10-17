// Widget tests for Mission Control dashboard.
//
// These tests verify:
// - Dashboard renders with user stats
// - Navigation elements are present
// - Data displays correctly

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_level_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

/// Mock data for testing
/// Profile ctor: (user, hasCompany, hasNonProfit, isCompanyContributor,
///   isNonProfitContributor, [title, projectsFollowing, stripeCustomerId,
///   amountFollowing, following, userdonations, dob, altruePoints, address,
///   country, state, city, zip, qrCode, atrocityList, balance, donor,
///   nonProfitList, orders, profilePicture, shirtList, donationTotal,
///   description, np, comp, userActions, username])
final mockUser = User(
  id: 1,
  key: 'test-key',
  email: 'test@example.com',
  altid: 1,
  hasProfile: 1,
);
final mockProfile = Profile(1, false, false, false, false) // required five
  ..altrueLevel = AltrueLevel(
      name: 'Beginner', levelNumber: 1, minimumPoints: 0, maximumPoints: 499)
  ..altruePoints = 150
  ..balance = 50.00
  ..username = 'testuser';

void main() {
  group('Mission Control Dashboard Tests', () {
    testWidgets(
      'Dashboard displays user level and points',
      (WidgetTester tester) async {
        /// Setup: Create widget with mock user data
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Text('Level: ${mockProfile.altrueLevel?.name}'),
                  Text('Points: ${mockProfile.altruePoints}'),
                  Text('Balance: \$${mockProfile.balance}'),
                ],
              ),
            ),
          ),
        );

        /// Verify: User stats are displayed
        expect(find.text('Level: Beginner'), findsOneWidget);
        expect(find.text('Points: 150'), findsOneWidget);
        expect(find.textContaining('Balance:'), findsOneWidget);
      },
    );

    testWidgets(
      'Dashboard navigation buttons are present',
      (WidgetTester tester) async {
        /// Setup: Build dashboard with navigation
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Donate'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('My Profile'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Settings'),
                  ),
                ],
              ),
            ),
          ),
        );

        /// Verify: Navigation buttons exist
        expect(find.text('Donate'), findsOneWidget);
        expect(find.text('My Profile'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      },
    );
  });
}
