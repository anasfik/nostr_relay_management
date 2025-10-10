import 'package:nostr_relay_management_api/src/methods_service.dart';
import 'package:nostr_relay_management_api/src/models/allowed_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_event_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/blocked_ip.dart';
import 'package:nostr_relay_management_api/src/models/needed_event_moderation.dart';
import 'package:test/test.dart';

void main() {
  group('NostrRelayManagementMethodsService', () {
    late NostrRelayManagementMethodsService service;

    setUp(() {
      service = NostrRelayManagementMethodsService(
        url: "https://test-relay.com",
        hexPrivateKey:
            "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
      );
    });

    group('Service Initialization', () {
      test('should initialize with required parameters', () {
        expect(service.url, equals("https://test-relay.com"));
        expect(
            service.hexPrivateKey,
            equals(
                "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41"));
      });

      test('should have networker initialized', () {
        expect(service.networker, isNotNull);
        expect(
            service.networker.hexPrivateKey,
            equals(
                "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41"));
      });
    });

    group('Method Signatures', () {
      test('should have supportedmethods method', () {
        expect(service.supportedmethods, isA<Function>());
      });

      test('should have banpubkey method', () {
        expect(service.banpubkey, isA<Function>());
      });

      test('should have allowpubkey method', () {
        expect(service.allowpubkey, isA<Function>());
      });

      test('should have listbannedpubkeys method', () {
        expect(service.listbannedpubkeys, isA<Function>());
      });

      test('should have listallowedpubkeys method', () {
        expect(service.listallowedpubkeys, isA<Function>());
      });

      test('should have banevent method', () {
        expect(service.banevent, isA<Function>());
      });

      test('should have allowevent method', () {
        expect(service.allowevent, isA<Function>());
      });

      test('should have listbannedevents method', () {
        expect(service.listbannedevents, isA<Function>());
      });

      test('should have listallowedevents method', () {
        expect(service.listallowedevents, isA<Function>());
      });

      test('should have listeventsneedingmoderation method', () {
        expect(service.listeventsneedingmoderation, isA<Function>());
      });

      test('should have changerelayname method', () {
        expect(service.changerelayname, isA<Function>());
      });

      test('should have changerelaydescription method', () {
        expect(service.changerelaydescription, isA<Function>());
      });

      test('should have changerelayicon method', () {
        expect(service.changerelayicon, isA<Function>());
      });

      test('should have allowkind method', () {
        expect(service.allowkind, isA<Function>());
      });

      test('should have disallowkind method', () {
        expect(service.disallowkind, isA<Function>());
      });

      test('should have listallowedkinds method', () {
        expect(service.listallowedkinds, isA<Function>());
      });

      test('should have listdisallowedkinds method', () {
        expect(service.listdisallowedkinds, isA<Function>());
      });

      test('should have blockip method', () {
        expect(service.blockip, isA<Function>());
      });

      test('should have unblockip method', () {
        expect(service.unblockip, isA<Function>());
      });

      test('should have listblockedips method', () {
        expect(service.listblockedips, isA<Function>());
      });

      test('should have stats method', () {
        expect(service.stats, isA<Function>());
      });

      test('should have grantadmin method', () {
        expect(service.grantadmin, isA<Function>());
      });

      test('should have revokeadmin method', () {
        expect(service.revokeadmin, isA<Function>());
      });

      test('should have customMethod method', () {
        expect(service.customMethod, isA<Function>());
      });
    });

    group('Return Types', () {
      test('supportedmethods should return Future<List<String>?>', () {
        final result = service.supportedmethods();
        expect(result, isA<Future<List<String>?>>());
      });

      test('banpubkey should return Future<bool?>', () {
        final result = service.banpubkey(pubkey: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('allowpubkey should return Future<bool?>', () {
        final result = service.allowpubkey(pubkey: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('listbannedpubkeys should return Future<List<BannedPubkeyInfo>?>',
          () {
        final result = service.listbannedpubkeys();
        expect(result, isA<Future<List<BannedPubkeyInfo>?>>());
      });

      test('listallowedpubkeys should return Future<List<AllowedPubkeyInfo>?>',
          () {
        final result = service.listallowedpubkeys();
        expect(result, isA<Future<List<AllowedPubkeyInfo>?>>());
      });

      test('banevent should return Future<bool?>', () {
        final result = service.banevent(eventId: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('allowevent should return Future<bool?>', () {
        final result = service.allowevent(eventId: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('listbannedevents should return Future<List<BannedEventInfo>?>', () {
        final result = service.listbannedevents();
        expect(result, isA<Future<List<BannedEventInfo>?>>());
      });

      test('listallowedevents should return Future<List<BannedEventInfo>?>',
          () {
        final result = service.listallowedevents();
        expect(result, isA<Future<List<BannedEventInfo>?>>());
      });

      test(
          'listeventsneedingmoderation should return Future<List<NeededEventModeration>?>',
          () {
        final result = service.listeventsneedingmoderation();
        expect(result, isA<Future<List<NeededEventModeration>?>>());
      });

      test('changerelayname should return Future<bool?>', () {
        final result = service.changerelayname(newName: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('changerelaydescription should return Future<bool?>', () {
        final result = service.changerelaydescription(newDescription: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('changerelayicon should return Future<bool?>', () {
        final result = service.changerelayicon(newIconUrl: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('allowkind should return Future<bool?>', () {
        final result = service.allowkind(kind: 1);
        expect(result, isA<Future<bool?>>());
      });

      test('disallowkind should return Future<bool?>', () {
        final result = service.disallowkind(kind: 1);
        expect(result, isA<Future<bool?>>());
      });

      test('listallowedkinds should return Future<List<int>?>', () {
        final result = service.listallowedkinds();
        expect(result, isA<Future<List<int>?>>());
      });

      test('listdisallowedkinds should return Future<List<int>?>', () {
        final result = service.listdisallowedkinds();
        expect(result, isA<Future<List<int>?>>());
      });

      test('blockip should return Future<bool?>', () {
        final result = service.blockip(ip: "192.168.1.1");
        expect(result, isA<Future<bool?>>());
      });

      test('unblockip should return Future<bool?>', () {
        final result = service.unblockip(ip: "192.168.1.1");
        expect(result, isA<Future<bool?>>());
      });

      test('listblockedips should return Future<List<BlockedIp>?>', () {
        final result = service.listblockedips();
        expect(result, isA<Future<List<BlockedIp>?>>());
      });

      test('stats should return Future<Map<String, dynamic>?>', () {
        final result = service.stats();
        expect(result, isA<Future<Map<String, dynamic>?>>());
      });

      test('grantadmin should return Future<bool?>', () {
        final result = service.grantadmin(pubkey: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('revokeadmin should return Future<bool?>', () {
        final result = service.revokeadmin(pubkey: "test");
        expect(result, isA<Future<bool?>>());
      });

      test('customMethod should return Future<T?>', () {
        final result = service.customMethod<String>(
          methodName: "test",
          adapter: (result) => result as String,
        );
        expect(result, isA<Future<String?>>());
      });
    });
  });
}
