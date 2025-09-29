class NeededEventModeration {
  final String id;
  final String? reason;

  NeededEventModeration({
    required this.id,
    this.reason,
  });

  factory NeededEventModeration.fromJson(Map<String, dynamic> json) {
    return NeededEventModeration(
      id: json['id'] as String,
      reason: json['reason'] as String?,
    );
  }
}
