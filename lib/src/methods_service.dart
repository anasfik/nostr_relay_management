import 'package:nostr_relay_management_api/src/methods_service_base.dart';
import 'package:nostr_relay_management_api/src/models/allowed_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_event_info.dart';
import 'package:nostr_relay_management_api/src/models/banned_pubkey_info.dart';
import 'package:nostr_relay_management_api/src/models/blocked_ip.dart';
import 'package:nostr_relay_management_api/src/models/needed_event_moderation.dart';
import 'package:nostr_relay_management_api/src/networker.dart';

class NostrRelayManagementMethodsService
    implements NostrRelayManagementMethodsServiceBase {
  final String url;

  final String hexPrivateKey;

  NostrRelayManagementMethodsService({
    required this.url,
    required this.hexPrivateKey,
  });

  late final networker = NostrRelayManagementNetworker(
    hexPrivateKey: hexPrivateKey,
  );

  @override
  Future<bool?> allowevent({
    required String eventId,
    String? reason,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "allowevent",
      params: [eventId, reason],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> allowkind({
    required int kind,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "allowkind",
      params: [kind],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> allowpubkey({
    required String pubkey,
    String? reason,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "allowpubkey",
      params: [pubkey, reason],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> banevent({
    required String eventId,
    String? reason,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "banevent",
      params: [eventId, reason],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> banpubkey({
    required String pubkey,
    String? reason,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "banpubkey",
      params: [pubkey, reason],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> blockip({
    required String ip,
    String? reason,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "blockip",
      params: [ip, reason],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> unblockip({
    required String ip,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "unblockip",
      params: [ip],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> changerelaydescription({
    required String newDescription,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "changerelaydescription",
      params: [newDescription],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> changerelayicon({
    required String newIconUrl,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "changerelayicon",
      params: [newIconUrl],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> changerelayname({
    required String newName,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "changerelayname",
      params: [newName],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> disallowkind({
    required int kind,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "disallowkind",
      params: [kind],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<List<int>?> listallowedkinds() async {
    return networker.sendRequest(
      url: url,
      methodName: "listallowedkinds",
      params: [],
      adapter: (result) {
        return (result as List).map((e) => e as int).toList();
      },
    );
  }

  @override
  Future<List<int>?> listdisallowedkinds() async {
    return networker.sendRequest(
      url: url,
      methodName: "listdisallowedkinds",
      params: [],
      adapter: (result) {
        return (result as List).map((e) => e as int).toList();
      },
    );
  }

  @override
  Future<List<BannedEventInfo>?> listallowedevents() async {
    return networker.sendRequest(
      url: url,
      methodName: "listallowedevents",
      params: [],
      adapter: (result) {
        return (result as List)
            .map((e) => BannedEventInfo.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<Map<String, dynamic>?> stats() async {
    return networker.sendRequest(
      url: url,
      methodName: "stats",
      params: [],
      adapter: (result) {
        return result as Map<String, dynamic>;
      },
    );
  }

  @override
  Future<bool?> grantadmin({
    required String pubkey,
    List<String>? methods,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "grantadmin",
      params: [pubkey, methods],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<bool?> revokeadmin({
    required String pubkey,
    List<String>? methods,
  }) async {
    return networker.sendRequest(
      url: url,
      methodName: "revokeadmin",
      params: [pubkey, methods],
      adapter: (result) {
        return result as bool;
      },
    );
  }

  @override
  Future<List<AllowedPubkeyInfo>?> listallowedpubkeys() async {
    return networker.sendRequest(
      url: url,
      methodName: "listallowedpubkeys",
      params: [],
      adapter: (result) {
        return (result as List)
            .map((e) => AllowedPubkeyInfo.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<List<BannedEventInfo>?> listbannedevents() async {
    return networker.sendRequest(
      url: url,
      methodName: "listbannedevents",
      params: [],
      adapter: (result) {
        return (result as List)
            .map((e) => BannedEventInfo.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<List<BannedPubkeyInfo>?> listbannedpubkeys() async {
    return networker.sendRequest(
      url: url,
      methodName: "listbannedpubkeys",
      params: [],
      adapter: (result) {
        return (result as List)
            .map((e) => BannedPubkeyInfo.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<List<BlockedIp>?> listblockedips() async {
    return networker.sendRequest(
      url: url,
      methodName: "listblockedips",
      params: [],
      adapter: (result) {
        return (result as List).map((e) => BlockedIp.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<List<NeededEventModeration>?> listeventsneedingmoderation() async {
    return networker.sendRequest(
      url: url,
      methodName: "listeventsneedingmoderation",
      params: [],
      adapter: (result) {
        return (result as List)
            .map((e) => NeededEventModeration.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<List<String>?> supportedmethods() async {
    return networker.sendRequest(
      url: url,
      methodName: "supportedmethods",
      params: [],
      adapter: (result) {
        return (result as List).map((e) => e as String).toList();
      },
    );
  }

  @override
  Future<T?> customMethod<T>({
    required String methodName,
    required T Function(Object? result) adapter,
    List<Object?>? params,
  }) {
    return networker.sendRequest(
      url: url,
      methodName: methodName,
      params: params ?? [],
      adapter: adapter,
    );
  }
}
