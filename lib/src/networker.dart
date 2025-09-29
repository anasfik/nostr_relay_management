import 'package:crypto/crypto.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nostr_relay_management_api/src/nostr_auth.dart';

class NostrRelayManagementNetworker {
  final String hexPrivateKey;

  NostrRelayManagementNetworker({
    required this.hexPrivateKey,
  });

  Future<T> sendRequest<T>({
    required String url,
    required String methodName,
    required List params,
    required T Function(dynamic result) adapter,
  }) async {
    final body = {
      'method': methodName,
      'params': params,
    };

    final nostrToken = NostrAuthService.requestToken(
      keyPair: NostrKeyPairs(private: hexPrivateKey),
      endpoint: url,
      method: "POST",
      payload: sha256.convert(utf8.encode(jsonEncode(body))).toString(),
    );

    final requestHeaders = {
      'Content-Type': 'application/nostr+json+rpc',
      'Accept': 'application/json',
      'Authorization': 'Nostr $nostrToken',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Response body: ${response.body}");

        final decodedRes = jsonDecode(response.body) as Map<String, dynamic>;
        final error = decodedRes["error"];

        if (error is String && error.isNotEmpty) {
          throw Exception(error);
        }

        final successData = decodedRes["result"];
        final result = adapter(successData);

        return result;
      } else {
        throw Exception(
          'Request failed with status: ${response.statusCode}, body: ${response.body}',
        );
      }
    } catch (e) {
      // ...
      rethrow;
    }
  }
}
