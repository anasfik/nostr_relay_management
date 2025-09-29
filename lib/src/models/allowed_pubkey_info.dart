class AllowedPubkeyInfo {
  final String pubkey;
  final String? reason;

  AllowedPubkeyInfo({
    required this.pubkey,
    this.reason,
  });

  factory AllowedPubkeyInfo.fromJson(Map<String, dynamic> json) {
    return AllowedPubkeyInfo(
      pubkey: json['pubkey'] as String,
      reason: json['reason'] as String?,
    );
  }
}
