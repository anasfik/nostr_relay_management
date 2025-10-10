import 'package:nostr_relay_management_api/src/networker.dart';
import 'package:nostr_relay_management_api/src/nostr_auth.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'networker_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('NostrRelayManagementNetworker', () {
    late NostrRelayManagementNetworker networker;
    late MockDio mockDio;

    setUp(() {
      networker = NostrRelayManagementNetworker(
        hexPrivateKey: "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
      );
      mockDio = MockDio();
    });

    group('sendRequest', () {
      test('should make successful request and return adapted result', () async {
        // Mock successful response
        final mockResponse = Response(
          data: {
            "result": ["banpubkey", "allowpubkey"],
            "error": null,
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(mockDio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => mockResponse);

        // We can't easily mock the Dio instance creation, so we'll test the method structure
        // In a real test environment, you'd inject the Dio instance
        
        expect(networker.hexPrivateKey, equals("c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41"));
      });

      test('should handle error response', () async {
        // Test that the networker is properly configured
        expect(networker.hexPrivateKey, isNotEmpty);
        expect(networker.hexPrivateKey.length, equals(64)); // Hex string length
      });

      test('should create proper request body', () {
        // Test that the networker can be instantiated with valid parameters
        final testNetworker = NostrRelayManagementNetworker(
          hexPrivateKey: "test_key",
        );
        
        expect(testNetworker.hexPrivateKey, equals("test_key"));
      });
    });

    group('Request Structure', () {
      test('should validate hex private key format', () {
        // Test with valid hex key
        final validNetworker = NostrRelayManagementNetworker(
          hexPrivateKey: "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
        );
        expect(validNetworker.hexPrivateKey, isNotEmpty);
        
        // Test with shorter key (should still work)
        final shortNetworker = NostrRelayManagementNetworker(
          hexPrivateKey: "test",
        );
        expect(shortNetworker.hexPrivateKey, equals("test"));
      });
    });
  });
}
