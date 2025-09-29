class BlockedIp {
  final String ip;
  final String? reason;

  BlockedIp({
    required this.ip,
    this.reason,
  });

  factory BlockedIp.fromJson(Map<String, dynamic> json) {
    return BlockedIp(
      ip: json['ip'] as String,
      reason: json['reason'] as String?,
    );
  }
}
