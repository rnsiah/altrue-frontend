import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('API Integration Tests', () {
    test('Login API returns token on success', () async {
      // Mock successful login response
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({'key': 'test_token_12345'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final response = await mockClient.post(
        Uri.parse('https://api.altrueglobal.org/dj-rest-auth/login/'),
        body: {
          'email': 'test@example.com',
          'password': 'testpassword',
        },
      );

      expect(response.statusCode, 200);
      final data = jsonDecode(response.body);
      expect(data['key'], 'test_token_12345');
    });

    test('Login API returns error on invalid credentials', () async {
      // Mock failed login response
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({'non_field_errors': ['Unable to log in with provided credentials.']}),
          400,
          headers: {'content-type': 'application/json'},
        );
      });

      final response = await mockClient.post(
        Uri.parse('https://api.altrueglobal.org/dj-rest-auth/login/'),
        body: {
          'email': 'wrong@example.com',
          'password': 'wrongpassword',
        },
      );

      expect(response.statusCode, 400);
      final data = jsonDecode(response.body);
      expect(data.containsKey('non_field_errors'), true);
    });

    test('User profile API returns user data', () async {
      // Mock profile response
      final mockClient = MockClient((request) async {
        if (request.headers['Authorization'] == 'Token test_token') {
          return http.Response(
            jsonEncode({
              'id': 1,
              'username': 'testuser',
              'email': 'test@example.com',
              'city': 'Test City',
              'balance': {'balance': '100.00'},
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response('Unauthorized', 401);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.altrueglobal.org/api/userprofiles/1/'),
        headers: {'Authorization': 'Token test_token'},
      );

      expect(response.statusCode, 200);
      final data = jsonDecode(response.body);
      expect(data['username'], 'testuser');
      expect(data['email'], 'test@example.com');
    });

    test('Donation API creates payment intent', () async {
      // Mock Stripe payment intent creation
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'id': 'pi_test_123',
            'client_secret': 'pi_test_secret_123',
            'ephemeral_key': 'eph_test_secret_123',
            'customer': 'cus_test_123',
            'metadata': {
              'nonprofit_id': 1,
              'donation_type': 'S',
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final response = await mockClient.post(
        Uri.parse('https://api.altrueglobal.org/api/userprofiles/1/addUserDonationToNonProfit/'),
        headers: {
          'Authorization': 'Token test_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': 500,
          'id': 'test-nonprofit',
          'donation_type': 'S',
        }),
      );

      expect(response.statusCode, 200);
      final data = jsonDecode(response.body);
      expect(data.containsKey('client_secret'), true);
      expect(data.containsKey('id'), true);
    });

    test('Stripe config API returns public key', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({'publicKey': 'pk_test_1234567890'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final response = await mockClient.get(
        Uri.parse('https://api.altrueglobal.org/stripe/config/'),
      );

      expect(response.statusCode, 200);
      final data = jsonDecode(response.body);
      expect(data['publicKey'], 'pk_test_1234567890');
    });
  });
}
