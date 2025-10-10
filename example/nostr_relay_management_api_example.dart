import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';

// Custom data class for the backup example
class RelayBackupDetails {
  final int backedUpEvents;
  final int backedUpFiles;
  final String backupLocation;

  RelayBackupDetails({
    required this.backedUpEvents,
    required this.backedUpFiles,
    required this.backupLocation,
  });

  @override
  String toString() {
    return 'RelayBackupDetails(backedUpEvents: $backedUpEvents, backedUpFiles: $backedUpFiles, backupLocation: $backupLocation)';
  }
}

void main() async {
  final relay = "http://localhost:3334";

  final relayManagementService = NostrRelayManagement(
    hexPrivateKey:
        "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
    url: relay,
  );

  print("=== NIP-86 Relay Management API Demo ===\n");

  // 1. List supported methods
  print("1. Getting supported methods:");
  final supportedMethods =
      await relayManagementService.methods.supportedmethods();
  print("Supported methods: $supportedMethods\n");

  // 2. List allowed kinds
  print("2. Getting allowed kinds:");
  final allowedKinds = await relayManagementService.methods.listallowedkinds();
  print("Allowed kinds: $allowedKinds\n");

  // 3. List disallowed kinds
  print("3. Getting disallowed kinds:");
  final disallowedKinds =
      await relayManagementService.methods.listdisallowedkinds();
  print("Disallowed kinds: $disallowedKinds\n");

  // 4. List allowed pubkeys
  print("4. Getting allowed pubkeys:");
  final allowedPubkeys =
      await relayManagementService.methods.listallowedpubkeys();
  print("Allowed pubkeys: $allowedPubkeys\n");

  // 5. List banned pubkeys
  print("5. Getting banned pubkeys:");
  final bannedPubkeys =
      await relayManagementService.methods.listbannedpubkeys();
  print("Banned pubkeys: $bannedPubkeys\n");

  // 6. List allowed events
  print("6. Getting allowed events:");
  final allowedEvents =
      await relayManagementService.methods.listallowedevents();
  print("Allowed events: $allowedEvents\n");

  // 7. List banned events
  print("7. Getting banned events:");
  final bannedEvents = await relayManagementService.methods.listbannedevents();
  print("Banned events: $bannedEvents\n");

  // 8. List events needing moderation
  print("8. Getting events needing moderation:");
  final eventsNeedingModeration =
      await relayManagementService.methods.listeventsneedingmoderation();
  print("Events needing moderation: $eventsNeedingModeration\n");

  // 9. List blocked IPs
  print("9. Getting blocked IPs:");
  final blockedIPs = await relayManagementService.methods.listblockedips();
  print("Blocked IPs: $blockedIPs\n");

  // 10. Get relay stats
  print("10. Getting relay stats:");
  final stats = await relayManagementService.methods.stats();
  print("Relay stats: $stats\n");

  // 11. Pubkey management operations
  print("11. Testing pubkey management:");
  final testPubkey = "test_pubkey_123";

  // Ban a pubkey
  final banResult = await relayManagementService.methods.banpubkey(
    pubkey: testPubkey,
    reason: "Testing ban functionality",
  );
  print("Ban pubkey result: $banResult");

  // Allow a pubkey
  final allowResult = await relayManagementService.methods.allowpubkey(
    pubkey: testPubkey,
    reason: "Testing allow functionality",
  );
  print("Allow pubkey result: $allowResult\n");

  // 12. Event management operations
  print("12. Testing event management:");
  final testEventId = "test_event_123";

  // Ban an event
  final banEventResult = await relayManagementService.methods.banevent(
    eventId: testEventId,
    reason: "Testing event ban functionality",
  );
  print("Ban event result: $banEventResult");

  // Allow an event
  final allowEventResult = await relayManagementService.methods.allowevent(
    eventId: testEventId,
    reason: "Testing event allow functionality",
  );
  print("Allow event result: $allowEventResult\n");

  // 13. Kind management operations
  print("13. Testing kind management:");
  final testKind = 9999;

  // Allow a kind
  final allowKindResult =
      await relayManagementService.methods.allowkind(kind: testKind);
  print("Allow kind result: $allowKindResult");

  // Disallow a kind
  final disallowKindResult =
      await relayManagementService.methods.disallowkind(kind: testKind);
  print("Disallow kind result: $disallowKindResult\n");

  // 14. IP management operations
  print("14. Testing IP management:");
  final testIP = "192.168.1.100";

  // Block an IP
  final blockIPResult = await relayManagementService.methods.blockip(
    ip: testIP,
    reason: "Testing IP block functionality",
  );
  print("Block IP result: $blockIPResult");

  // Unblock an IP
  final unblockIPResult =
      await relayManagementService.methods.unblockip(ip: testIP);
  print("Unblock IP result: $unblockIPResult\n");

  // 15. Relay metadata operations
  print("15. Testing relay metadata changes:");

  // Change relay name
  final changeNameResult = await relayManagementService.methods.changerelayname(
    newName: "Updated Relay Name",
  );
  print("Change relay name result: $changeNameResult");

  // Change relay description
  final changeDescResult =
      await relayManagementService.methods.changerelaydescription(
    newDescription: "Updated relay description for testing",
  );
  print("Change relay description result: $changeDescResult");

  // Change relay icon
  final changeIconResult = await relayManagementService.methods.changerelayicon(
    newIconUrl: "https://example.com/new-icon.png",
  );
  print("Change relay icon result: $changeIconResult\n");

  // 16. Admin management operations
  print("16. Testing admin management:");
  final adminPubkey = "admin_pubkey_123";
  final adminMethods = ["banpubkey", "allowpubkey", "banevent"];

  // Grant admin
  final grantAdminResult = await relayManagementService.methods.grantadmin(
    pubkey: adminPubkey,
    methods: adminMethods,
  );
  print("Grant admin result: $grantAdminResult");

  // Revoke admin
  final revokeAdminResult = await relayManagementService.methods.revokeadmin(
    pubkey: adminPubkey,
    methods: adminMethods,
  );
  print("Revoke admin result: $revokeAdminResult\n");

  // 17. Custom method example
  print("17. Testing custom method:");
  RelayBackupDetails? custom =
      await relayManagementService.methods.customMethod(
    methodName: "backupdatabaseInternally",
    adapter: (result) {
      final details = result as List<dynamic>;
      final detailsInfo = details.firstOrNull as Map<String, dynamic>?;

      final backedUpEvents = detailsInfo?['backedUpEvents'] as int?;
      final backedUpFiles = detailsInfo?['backedUpFiles'] as int?;
      final backupLocation = detailsInfo?['backupLocation'] as String?;

      return RelayBackupDetails(
        backedUpEvents: backedUpEvents ?? 0,
        backedUpFiles: backedUpFiles ?? 0,
        backupLocation: backupLocation ?? 'unknown',
      );
    },
  );
  print("Custom method result: $custom\n");

  print("=== Demo completed successfully! ===");
}
