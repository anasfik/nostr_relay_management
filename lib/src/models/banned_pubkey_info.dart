class BannedPubkeyInfo {
  final String pubkey;
  final String? reason;

  BannedPubkeyInfo({
    required this.pubkey,
    this.reason,
  });

  factory BannedPubkeyInfo.fromJson(Map<String, dynamic> json) {
    return BannedPubkeyInfo(
      pubkey: json['pubkey'] as String,
      reason: json['reason'] as String?,
    );
  }
}
