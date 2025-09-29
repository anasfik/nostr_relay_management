import 'methods_service.dart';

class NostrRelayManagement {
  final String url;

  final String hexPrivateKey;

  NostrRelayManagement({
    required this.url,
    required this.hexPrivateKey,
  });

  late final methods = NostrRelayManagementMethodsService(
    hexPrivateKey: hexPrivateKey,
    url: url,
  );
}
