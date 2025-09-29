import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';

class NostrAuthService {
  static NostrEvent generateEvent({
    required NostrKeyPairs keyPair,
    required String url,
    required String method,
    String? payload,
  }) {
    final ev = NostrEvent.fromPartialData(
      kind: 27235,
      content: '',
      keyPairs: keyPair,
      tags: [
        ['u', url],
        ['method', method],
        if (payload != null) ['payload', payload],
      ],
    );

    return ev;
  }

  static String encodeEventBase64({
    required NostrEvent event,
  }) {
    final asMap = {
      'id': event.id,
      'kind': event.kind,
      'content': event.content,
      'sig': event.sig,
      'pubkey': event.pubkey,
      'created_at': event.createdAt.millisecondsSinceEpoch ~/ 1000,
      'tags': event.tags,
    };

    final asJson = jsonEncode(asMap);
    final asBase64 = base64Encode(utf8.encode(asJson));

    return asBase64;
  }

  static String requestToken({
    required NostrKeyPairs keyPair,
    required String endpoint,
    String method = "GET",
    String? payload,
  }) {
    final ev = generateEvent(
      keyPair: keyPair,
      url: endpoint,
      method: method,
      payload: payload,
    );

    final base64 = encodeEventBase64(
      event: ev,
    );

    return base64;
  }
}
