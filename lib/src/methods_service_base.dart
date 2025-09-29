import 'package:nostr_relay_management_api/src/models/banned_event_info.dart';
import 'package:nostr_relay_management_api/src/models/blocked_ip.dart';
import 'package:nostr_relay_management_api/src/models/needed_event_moderation.dart';

import 'models/allowed_pubkey_info.dart';
import 'models/banned_pubkey_info.dart';

abstract interface class NostrRelayManagementMethodsServiceBase {
  Future<List<String>> supportedmethods();

  Future<bool> banpubkey({
    required String pubkey,
    String? reason,
  });

  Future<List<BannedPubkeyInfo>> listbannedpubkeys();

  Future<bool> allowpubkey({
    required String pubkey,
    String? reason,
  });

  Future<List<AllowedPubkeyInfo>> listallowedpubkeys();

  Future<List<NeededEventModeration>> listeventsneedingmoderation();

  Future<bool> allowevent({
    required String eventId,
    String? reason,
  });
  Future<bool> banevent({
    required String eventId,
    String? reason,
  });

  Future<List<BannedEventInfo>> listbannedevents();

  Future<bool> changerelayname({
    required String newName,
  });

  Future<bool> changerelaydescription({
    required String newDescription,
  });

  Future<bool> changerelayicon({
    required String newIconUrl,
  });

  Future<bool> allowkind({
    required int kind,
  });

  Future<bool> disallowkind({
    required int kind,
  });

  Future<List<int>> listallowedkinds();

  Future<bool> blockip({
    required String ip,
    String? reason,
  });

  Future<bool> unblockip({
    required String ip,
  });

  Future<List<BlockedIp>> listblockedips();
}
