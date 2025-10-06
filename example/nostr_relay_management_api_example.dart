import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';

void main() async  {
  final relays = ["http://localhost:3334"];

  for (var relay in relays) {
    final relayManagementService = NostrRelayManagement(
      hexPrivateKey:
          "c5ff35d0df9e3208e73b431106010be7842bd2618c71e857c0ad6133a904ad41",
      url: relay,
    );

    final kinds =
        await relayManagementService.methods.listallowedkinds();
  }
}
