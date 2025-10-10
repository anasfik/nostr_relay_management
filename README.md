# 🚀 Nostr Relay Management API for Dart/Flutter

[![pub package](https://img.shields.io/pub/v/nostr_relay_management_api.svg)](https://pub.dev/packages/nostr_relay_management_api)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive Dart/Flutter package that makes **NIP-86 Relay Management** simple and easy! This package abstracts away the complexity of [NIP-98 HTTP Authentication](https://github.com/nostr-protocol/nips/blob/master/98.md) and provides a clean, type-safe API for managing Nostr relays.

## ✨ What is NIP-86?

[NIP-86](https://github.com/nostr-protocol/nips/blob/master/86.md) defines a standardized API for managing Nostr relays. It allows you to:

- 🚫 **Ban/Allow** users and events
- 📊 **Monitor** relay statistics and moderation queues
- ⚙️ **Configure** relay settings (name, description, icon)
- 🔒 **Manage** admin permissions
- 🌐 **Block/Unblock** IP addresses
- 📝 **Control** event kinds (allow/disallow specific types)

## 🎯 Why Use This Package?

- ✅ **Complete NIP-86 Coverage** - All 23+ management methods supported
- 🔐 **Secure Authentication** - Handles NIP-98 auth automatically
- 🎨 **Type-Safe** - Full Dart type safety with proper models
- 🚀 **Easy to Use** - Simple, intuitive API design
- 🧪 **Well Tested** - Comprehensive example with real relay testing
- 📱 **Flutter Ready** - Works seamlessly in Flutter apps

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  nostr_relay_management_api: ^latest_version
```

Then run:

```bash
flutter pub get
# or
dart pub get
```

## 🚀 Quick Start

```dart
import 'package:nostr_relay_management_api/nostr_relay_management_api.dart';

void main() async {
  // Initialize the relay management service
  final relay = NostrRelayManagement(
    hexPrivateKey: "your_private_key_here", // Your Nostr private key
    url: "https://your-relay.com",          // Relay URL that supports NIP-86
  );

  // Get supported methods
  final methods = await relay.methods.supportedmethods();
  print('Available methods: $methods');

  // List banned users
  final bannedUsers = await relay.methods.listbannedpubkeys();
  print('Banned users: $bannedUsers');
}
```

## 📚 Complete API Reference

### 🔍 **Discovery & Information**

#### Get Supported Methods

```dart
final methods = await relay.methods.supportedmethods();
// Returns: List of all available management methods
```

#### Get Relay Statistics

```dart
final stats = await relay.methods.stats();
// Returns: Map with relay statistics and metrics
```

### 👥 **User Management**

#### Ban a User

```dart
final success = await relay.methods.banpubkey(
  pubkey: "npub1...",
  reason: "Spam behavior"
);
```

#### Allow a User

```dart
final success = await relay.methods.allowpubkey(
  pubkey: "npub1...",
  reason: "Appealed successfully"
);
```

#### List Banned Users

```dart
final bannedUsers = await relay.methods.listbannedpubkeys();
bannedUsers?.forEach((user) {
  print('Banned: ${user.pubkey} - ${user.reason}');
});
```

#### List Allowed Users

```dart
final allowedUsers = await relay.methods.listallowedpubkeys();
allowedUsers?.forEach((user) {
  print('Whitelisted: ${user.pubkey} - ${user.reason}');
});
```

### 📝 **Event Management**

#### Ban an Event

```dart
final success = await relay.methods.banevent(
  eventId: "event_id_here",
  reason: "Inappropriate content"
);
```

#### Allow an Event

```dart
final success = await relay.methods.allowevent(
  eventId: "event_id_here",
  reason: "Content reviewed and approved"
);
```

#### List Banned Events

```dart
final bannedEvents = await relay.methods.listbannedevents();
bannedEvents?.forEach((event) {
  print('Banned Event: ${event.id} - ${event.reason}');
});
```

#### List Allowed Events

```dart
final allowedEvents = await relay.methods.listallowedevents();
allowedEvents?.forEach((event) {
  print('Whitelisted Event: ${event.id} - ${event.reason}');
});
```

#### Events Needing Moderation

```dart
final pendingEvents = await relay.methods.listeventsneedingmoderation();
pendingEvents?.forEach((event) {
  print('Needs Review: ${event.id} - ${event.reason}');
});
```

### 🎛️ **Kind Management**

#### Allow Event Kind

```dart
final success = await relay.methods.allowkind(kind: 1); // Text notes
```

#### Disallow Event Kind

```dart
final success = await relay.methods.disallowkind(kind: 4); // Encrypted DMs
```

#### List Allowed Kinds

```dart
final allowedKinds = await relay.methods.listallowedkinds();
print('Allowed kinds: $allowedKinds'); // [0, 1, 3, ...]
```

#### List Disallowed Kinds

```dart
final disallowedKinds = await relay.methods.listdisallowedkinds();
print('Disallowed kinds: $disallowedKinds'); // [4, 5, 6, ...]
```

### 🌐 **IP Management**

#### Block IP Address

```dart
final success = await relay.methods.blockip(
  ip: "192.168.1.100",
  reason: "DoS attack detected"
);
```

#### Unblock IP Address

```dart
final success = await relay.methods.unblockip(ip: "192.168.1.100");
```

#### List Blocked IPs

```dart
final blockedIPs = await relay.methods.listblockedips();
blockedIPs?.forEach((ip) {
  print('Blocked IP: ${ip.ip} - ${ip.reason}');
});
```

### ⚙️ **Relay Configuration**

#### Change Relay Name

```dart
final success = await relay.methods.changerelayname(
  newName: "My Awesome Relay"
);
```

#### Change Relay Description

```dart
final success = await relay.methods.changerelaydescription(
  newDescription: "A fast and reliable Nostr relay"
);
```

#### Change Relay Icon

```dart
final success = await relay.methods.changerelayicon(
  newIconUrl: "https://example.com/relay-icon.png"
);
```

### 👑 **Admin Management**

#### Grant Admin Permissions

```dart
final success = await relay.methods.grantadmin(
  pubkey: "npub1...",
  methods: ["banpubkey", "allowpubkey", "banevent"]
);
```

#### Revoke Admin Permissions

```dart
final success = await relay.methods.revokeadmin(
  pubkey: "npub1...",
  methods: ["banpubkey", "allowpubkey"]
);
```

### 🔧 **Custom Methods**

For relays with custom methods not covered by NIP-86:

```dart
// Example: Custom backup method
final backupResult = await relay.methods.customMethod<BackupInfo>(
  methodName: "backupdatabaseInternally",
  params: ["full", "compress"],
  adapter: (result) {
    final data = result as Map<String, dynamic>;
    return BackupInfo(
      backedUpEvents: data['events'] as int,
      backupLocation: data['location'] as String,
    );
  },
);
```

## 🧪 Testing & Examples

Check out the comprehensive example in `example/nostr_relay_management_api_example.dart` that demonstrates all 17 categories of NIP-86 functionality:

```bash
# Run the example (make sure you have a NIP-86 compatible relay running)
cd example
dart run nostr_relay_management_api_example.dart
```

## 🔐 Authentication

This package uses **NIP-98 HTTP Authentication** automatically. You just need to provide your Nostr private key, and the package handles:

- ✅ Creating proper authentication headers
- ✅ Signing requests with your private key
- ✅ Managing authentication tokens
- ✅ Error handling for auth failures

## 🛠️ Error Handling

All methods return nullable types and handle errors gracefully:

```dart
final result = await relay.methods.banpubkey(
  pubkey: "invalid_pubkey",
  reason: "test"
);

if (result == null) {
  print('Operation failed - check logs for details');
} else {
  print('Success: $result');
}
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

- 🐛 **Report bugs** - Open an issue with details
- 💡 **Suggest features** - Propose new functionality
- 🔧 **Add methods** - Implement new NIP-86 methods as they're added
- 📖 **Improve docs** - Help make the documentation better
- 🧪 **Add tests** - Increase test coverage

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- 📖 [NIP-86 Specification](https://github.com/nostr-protocol/nips/blob/master/86.md)
- 🔐 [NIP-98 HTTP Auth](https://github.com/nostr-protocol/nips/blob/master/98.md)
- 📦 [Pub.dev Package](https://pub.dev/packages/nostr_relay_management_api)
- 🐙 [GitHub Repository](https://github.com/anasfik/nostr_relay_management)

---

**Made with ❤️ for the Nostr community**
