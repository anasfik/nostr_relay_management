import 'package:crypto/crypto.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:nostr_relay_management_api/src/nostr_auth.dart';

class NostrRelayManagementNetworker {
  final String hexPrivateKey;

  NostrRelayManagementNetworker({
    required this.hexPrivateKey,
  });

  Future<T?> sendRequest<T>({
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
      'Authorization': 'Nostr $nostrToken',
      'Content-Type': 'application/nostr+json+rpc',
      'charset': 'utf-8',
    };

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: requestHeaders,
          responseType: ResponseType.json,
          validateStatus: (status) =>
              status != null && status >= 200 && status < 500,
        ),
      );

      final response = await dio.post(
        '',
        data: jsonEncode(body),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final decodedRes = jsonDecode(response.data) as Map<String, dynamic>;

        print("Response body: $decodedRes");

        final error = decodedRes["error"];

        if (error is String && error.isNotEmpty) {
          throw Exception(error);
        }

        final successData = decodedRes["result"];

        print("result: $successData");

        final result = adapter(successData);

        return result;
      } else {
        throw Exception(
          'Request failed with status: ${response.statusCode}, body: ${response.data}',
        );
      }
    } catch (e) {
      // ...
    }
  }
}
