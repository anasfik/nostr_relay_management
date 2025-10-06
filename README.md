# What is this ?

This is a package that makes Nostr [NIP-86](https://github.com/nostr-protocol/nips/blob/master/86.md) support and usage easier for Dart/Flutter apps, abstracting away [Nip-98](https://github.com/nostr-protocol/nips/blob/master/98.md) Nostr Auth header...

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  # add this
  nostr_relay_management_api:
```

Then run `flutter pub get` or `dart pub get` in your terminal.

## Usage

Every method in this package is static and accessible via `NostrRelayManagement`:

```dart
import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';

void main() async {

  final relayManagementService = NostrRelayManagement(
       // needed to make requests using NIP-98's HTTP authentication, if you have no ideon what this is, check https://github.com/nostr-protocol/nips/blob/master/98.md
      hexPrivateKey: "hexPrivateKey",

   // the relay that you want to use for NIP-86 requests
      url: "https://yourRelayThatSupportsNip86.com",
    );
}
```

### supportedmethods

```dart

  final  supportedmethods =
      await relayManagementService.methods.supportedmethods();

  print('supportedmethods: $supportedmethods');
```

### banpubkey

```dart
  final isBanned = await relayManagementService.methods.banpubkey(
    pubkey: "pubkeyToBan",
    reason: "Spammy behavior",
  );

  print("Ban pubkey result: $isBanned");
```

### listbannedpubkeys

```dart
  final isBanned = await relayManagementService.methods.banpubkey(
    pubkey: "pubkeyToBan",
    reason: "Spammy behavior",
  );

  print("Ban pubkey result: $isBanned");
```

### allowpubkey

```dart
  final isAllowed = await relayManagementService.methods.allowpubkey(
    pubkey: "pubkeyToAllow",
    reason: "Spammy behavior",

  );

  print("Allow pubkey result: $isAllowed");
```

### listallowedpubkeys

```dart
  final allowedPubkeys =
      await relayManagementService.methods.listallowedpubkeys();

  print("Allowed pubkeys: $allowedPubkeys");
```

### listeventsneedingmoderation

```dart
  final entries =
      await relayManagementService.methods.listeventsneedingmoderation();

  print(entries.map((e) {
    final eventId = e.id;
    final reason = e.reason;

    return 'Event ID: $eventId, Reason: $reason';
  }).toList());
```

### allowevent

```dart
  final isEventAllowed = await relayManagementService.methods.allowevent(
    eventId: "eventIdToAllow",
    reason: "This event is fine",
  );

  print("Allow event result: $isEventAllowed");
```

### banevent

```dart
    final isEventBanned = await relayManagementService.methods.banevent(
        eventId: "eventIdToBan",
        reason: "This event is inappropriate",
    );

    print("Ban event result: $isEventBanned");
```

### listbannedevents

```dart
  final bannedEvents =
      await relayManagementService.methods.listbannedevents();

  print(entries.map((e) {
    final eventId = e.id;
    final reason = e.reason;

    return 'Event ID: $eventId, Reason: $reason';
  }).toList());
```

### changerelayname

```dart
  final changed = await relayManagementService.methods.changerelayname(
    newName: "my new relay name",
  );

  print(changed);
```

### changerelaydescription

```dart
    final changed = await relayManagementService.methods.changerelaydescription(
        newDescription: "my new relay description",
    );

    print(changed);
```

### changerelayicon

```dart
    final changed = await relayManagementService.methods.changerelayicon(
        newIconUrl: "https://mydomain.com/myicon.png",
    );

    print(changed);
```

### allowkind

```dart
  final isKindAllowed = await relayManagementService.methods.allowkind(
    kind: 1,
  );

  print("Allow kind result: $isKindAllowed");
```

### disallowkind

```dart
  final isKindDisallowed = await relayManagementService.methods.disallowkind(
    kind: 1,
  );

  print("Disallow kind result: $isKindDisallowed");
```

### listallowedkinds

```dart
  final allowedKinds =
      await relayManagementService.methods.listallowedkinds();

  print("Allowed kinds: $allowedKinds");
```

### blockip

```dart
  final blocked = await relayManagementService.methods.blockip(
    ip: "104.0.25.3",
    reason: "maybe DoS attack",
  );

  print(blocked);
```

### unblockip

```dart
  final unblocked = await relayManagementService.methods.unblockip(
    ip: "104.0.25.3",
  );

  print(unblocked);
```

### listblockedips

```dart
  final blockedList = await relayManagementService.methods.listblockedips();

  print(blockedList.map((blockedIp) {
    final ip = blockedIp.ip;
    final reason = blockedIp.reason;

    return 'IP: $ip, Reason: $reason';
  }));
```

## Does your relay contain custom methods ?

- The package makes it possible to adapt to custom methods that your relay might have, like for example a method called `backupdatabaseInternally` that basically does a manual backup for all resources that the relay operate such as events, files, stats..., to support it, we can use the `customMethod` method:

```dart
  RelayBackupDetails? custom = await relayManagementService.methods.customMethod(
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

```

The type of`customMethod` is a:

```dart
  Future<T?> customMethod<T>({
    required String methodName,
    required T Function(Object? result) adapter,
    List<Object?>? params,
  })
```

which means that the response type is what you return in the `adapter` field

## Contributing

- if any more methods are added to NIP-86 in the future, please consider contributing by opening a PR/issue to add them.

- Also, if you find any bugs or have suggestions for improvements, feel free to open an issue on the GitHub repository.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
