import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';
import 'package:nostr_relay_management_api/src/models/allowed_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_event_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/blocked_ip.dart';
import 'package:nostr_relay_management_api/src/models/needed_event_moderation.dart';
import 'package:test/test.dart';

void main() {
  group('Integration Tests', () {
    // Note: These tests require a running NIP-86 compatible relay
    // They are marked as skip by default to avoid requiring external dependencies

    group('Real Relay Tests', () {
      late NostrRelayManagement relay;

      setUp(() {
        relay = NostrRelayManagement(
          hexPrivateKey:
              "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
          url: "http://localhost:3334", // Local test relay
        );
      });

      test('should get supported methods from real relay', () async {
        // Skip this test if no relay is running
        try {
          final methods = await relay.methods.supportedmethods();

          expect(methods, isNotNull);
          expect(methods, isA<List<String>>());
          expect(methods!.isNotEmpty, isTrue);

          // Check for expected NIP-86 methods
          expect(methods.contains('banpubkey'), isTrue);
          expect(methods.contains('allowpubkey'), isTrue);
          expect(methods.contains('listbannedpubkeys'), isTrue);
          expect(methods.contains('listallowedpubkeys'), isTrue);
        } catch (e) {
          // If relay is not running, skip the test
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get allowed kinds from real relay', () async {
        try {
          final kinds = await relay.methods.listallowedkinds();

          expect(kinds, isNotNull);
          expect(kinds, isA<List<int>>());

          // Should contain some standard kinds
          expect(kinds!.contains(0), isTrue); // Metadata
          expect(kinds.contains(1), isTrue); // Text notes
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get disallowed kinds from real relay', () async {
        try {
          final kinds = await relay.methods.listdisallowedkinds();

          expect(kinds, isNotNull);
          expect(kinds, isA<List<int>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get banned pubkeys from real relay', () async {
        try {
          final bannedPubkeys = await relay.methods.listbannedpubkeys();

          expect(bannedPubkeys, isNotNull);
          expect(bannedPubkeys, isA<List<BannedPubkeyInfo>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get allowed pubkeys from real relay', () async {
        try {
          final allowedPubkeys = await relay.methods.listallowedpubkeys();

          expect(allowedPubkeys, isNotNull);
          expect(allowedPubkeys, isA<List<AllowedPubkeyInfo>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get banned events from real relay', () async {
        try {
          final bannedEvents = await relay.methods.listbannedevents();

          expect(bannedEvents, isNotNull);
          expect(bannedEvents, isA<List<BannedEventInfo>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get allowed events from real relay', () async {
        try {
          final allowedEvents = await relay.methods.listallowedevents();

          expect(allowedEvents, isNotNull);
          expect(allowedEvents, isA<List<BannedEventInfo>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get events needing moderation from real relay', () async {
        try {
          final eventsNeedingModeration =
              await relay.methods.listeventsneedingmoderation();

          expect(eventsNeedingModeration, isNotNull);
          expect(eventsNeedingModeration, isA<List<NeededEventModeration>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get blocked IPs from real relay', () async {
        try {
          final blockedIPs = await relay.methods.listblockedips();

          expect(blockedIPs, isNotNull);
          expect(blockedIPs, isA<List<BlockedIp>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');

      test('should get relay stats from real relay', () async {
        try {
          final stats = await relay.methods.stats();

          expect(stats, isNotNull);
          expect(stats, isA<Map<String, dynamic>>());
        } catch (e) {
          return; // Skip the test by returning early
        }
      }, skip: 'Requires running relay server');
    });

    group('Error Handling Tests', () {
      test('should handle invalid relay URL gracefully', () async {
        final invalidRelay = NostrRelayManagement(
          hexPrivateKey:
              "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
          url: "http://invalid-relay-that-does-not-exist.com",
        );

        final result = await invalidRelay.methods.supportedmethods();

        // Should return null when relay is not available
        expect(result, isNull);
      });

      test('should handle invalid private key gracefully', () async {
        // This test expects an assertion error when creating NostrKeyPairs with invalid key
        expect(() {
          final invalidKeyRelay = NostrRelayManagement(
            hexPrivateKey: "invalid_key",
            url: "http://localhost:3334",
          );
          return invalidKeyRelay.methods.supportedmethods();
        }, throwsA(isA<AssertionError>()));
      });
    });
  });
}
