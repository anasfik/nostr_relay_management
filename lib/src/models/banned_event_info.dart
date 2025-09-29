class BannedEventInfo {
  final String id;
  final String? reason;

  BannedEventInfo({
    required this.id,
    this.reason,
  });

  factory BannedEventInfo.fromJson(Map<String, dynamic> json) {
    return BannedEventInfo(
      id: json['id'] as String,
      reason: json['reason'] as String?,
    );
  }
}
