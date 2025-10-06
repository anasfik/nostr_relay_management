import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';

void main() async {
  final relay = "http://localhost:3334";

  final relayManagementService = NostrRelayManagement(
    hexPrivateKey:
        "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
    url: relay,
  );

  final kinds = await relayManagementService.methods.listallowedkinds();

  RelayBackupDetails? custom =
      await relayManagementService.methods.customMethod(
    methodName: "backupdatabaseInternally",
    adapter: (result) {
      final details = result as List<dynamic>;
      final detailsIndo = details.firstOrNull as Map<String, dynamic>?;

      final backedUpEvents = detailsIndo?['backedUpEvents'] as int?;
      final backedUpFiles = detailsIndo?['backedUpFiles'] as int?;
      final backupLocation = detailsIndo?['backupLocation'] as String?;

      return RelayBackupDetails(
        backedUpEvents: backedUpEvents ?? 0,
        backedUpFiles: backedUpFiles ?? 0,
        backupLocation: backupLocation ?? 'unknown',
      );
    },
  );
}
