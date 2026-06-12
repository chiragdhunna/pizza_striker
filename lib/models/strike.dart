/// A single strike (`StrikeRead`).
class Strike {
  const Strike({
    required this.id,
    required this.userId,
    required this.reason,
    required this.status,
    required this.createdById,
    required this.revokedAt,
    required this.revokeReason,
    required this.pizzaEventId,
    required this.createdAt,
  });

  final int id;
  final int userId;
  final String reason;
  final String status; // 'active' | 'revoked' | 'cleared'
  final int? createdById;
  final DateTime? revokedAt;
  final String? revokeReason;
  final int? pizzaEventId;
  final DateTime? createdAt;

  bool get isActive => status == 'active';
  bool get isRevoked => status == 'revoked';
  bool get isCleared => status == 'cleared';

  factory Strike.fromJson(Map<String, dynamic> json) {
    return Strike(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      reason: json['reason']?.toString() ?? '',
      status: json['status']?.toString() ?? 'active',
      createdById: (json['created_by_id'] as num?)?.toInt(),
      revokedAt: json['revoked_at'] != null
          ? DateTime.tryParse(json['revoked_at'].toString())
          : null,
      revokeReason: json['revoke_reason']?.toString(),
      pizzaEventId: (json['pizza_event_id'] as num?)?.toInt(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
