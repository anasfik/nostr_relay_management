import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';
import 'package:nostr_relay_management_api/src/methods_service.dart';
import 'package:test/test.dart';

void main() {
  group('NostrRelayManagement', () {
    late NostrRelayManagement relayManagement;

    setUp(() {
      relayManagement = NostrRelayManagement(
        hexPrivateKey: "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
        url: "https://test-relay.com",
      );
    });

    test('should initialize with required parameters', () {
      expect(relayManagement.url, equals("https://test-relay.com"));
      expect(relayManagement.hexPrivateKey, equals("c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41"));
      expect(relayManagement.methods, isNotNull);
    });

    test('should have methods service available', () {
      expect(relayManagement.methods, isA<NostrRelayManagementMethodsService>());
    });
  });
}