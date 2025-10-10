import 'package:nostr_relay_management_api/src/models/allowed_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_event_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/blocked_ip.dart';
import 'package:nostr_relay_management_api/src/models/needed_event_moderation.dart';
import 'package:test/test.dart';

void main() {
  group('Model Classes', () {
    group('AllowedPubkeyInfo', () {
      test('should create instance with required fields', () {
        final info = AllowedPubkeyInfo(
          pubkey: "npub1test123",
          reason: "Trusted user",
        );

        expect(info.pubkey, equals("npub1test123"));
        expect(info.reason, equals("Trusted user"));
      });

      test('should create instance without optional reason', () {
        final info = AllowedPubkeyInfo(pubkey: "npub1test123");

        expect(info.pubkey, equals("npub1test123"));
        expect(info.reason, isNull);
      });

      test('should create from JSON', () {
        final json = {
          'pubkey': 'npub1test123',
          'reason': 'Trusted user',
        };

        final info = AllowedPubkeyInfo.fromJson(json);

        expect(info.pubkey, equals("npub1test123"));
        expect(info.reason, equals("Trusted user"));
      });

      test('should create from JSON without reason', () {
        final json = {'pubkey': 'npub1test123'};

        final info = AllowedPubkeyInfo.fromJson(json);

        expect(info.pubkey, equals("npub1test123"));
        expect(info.reason, isNull);
      });
    });

    group('BannedPubkeyInfo', () {
      test('should create instance with required fields', () {
        final info = BannedPubkeyInfo(
          pubkey: "npub1spam123",
          reason: "Spam behavior",
        );

        expect(info.pubkey, equals("npub1spam123"));
        expect(info.reason, equals("Spam behavior"));
      });

      test('should create from JSON', () {
        final json = {
          'pubkey': 'npub1spam123',
          'reason': 'Spam behavior',
        };

        final info = BannedPubkeyInfo.fromJson(json);

        expect(info.pubkey, equals("npub1spam123"));
        expect(info.reason, equals("Spam behavior"));
      });
    });

    group('BannedEventInfo', () {
      test('should create instance with required fields', () {
        final info = BannedEventInfo(
          id: "event123",
          reason: "Inappropriate content",
        );

        expect(info.id, equals("event123"));
        expect(info.reason, equals("Inappropriate content"));
      });

      test('should create from JSON', () {
        final json = {
          'id': 'event123',
          'reason': 'Inappropriate content',
        };

        final info = BannedEventInfo.fromJson(json);

        expect(info.id, equals("event123"));
        expect(info.reason, equals("Inappropriate content"));
      });
    });

    group('BlockedIp', () {
      test('should create instance with required fields', () {
        final blockedIp = BlockedIp(
          ip: "192.168.1.100",
          reason: "DoS attack",
        );

        expect(blockedIp.ip, equals("192.168.1.100"));
        expect(blockedIp.reason, equals("DoS attack"));
      });

      test('should create from JSON', () {
        final json = {
          'ip': '192.168.1.100',
          'reason': 'DoS attack',
        };

        final blockedIp = BlockedIp.fromJson(json);

        expect(blockedIp.ip, equals("192.168.1.100"));
        expect(blockedIp.reason, equals("DoS attack"));
      });
    });

    group('NeededEventModeration', () {
      test('should create instance with required fields', () {
        final moderation = NeededEventModeration(
          id: "event456",
          reason: "Needs review",
        );

        expect(moderation.id, equals("event456"));
        expect(moderation.reason, equals("Needs review"));
      });

      test('should create from JSON', () {
        final json = {
          'id': 'event456',
          'reason': 'Needs review',
        };

        final moderation = NeededEventModeration.fromJson(json);

        expect(moderation.id, equals("event456"));
        expect(moderation.reason, equals("Needs review"));
      });
    });
  });
}
