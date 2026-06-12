/// A pizza-party event owed by a user (`PizzaEventRead`).
class PizzaEvent {
  const PizzaEvent({
    required this.id,
    required this.userId,
    required this.strikeCount,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.fulfilledAt,
  });

  final int id;
  final int userId;
  final int strikeCount;
  final String status; // 'pending' | 'fulfilled' | 'cancelled'
  final String? notes;
  final DateTime? createdAt;
  final DateTime? fulfilledAt;

  bool get isPending => status == 'pending';
  bool get isFulfilled => status == 'fulfilled';
  bool get isCancelled => status == 'cancelled';

  factory PizzaEvent.fromJson(Map<String, dynamic> json) {
    return PizzaEvent(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      strikeCount: (json['strike_count'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? 'pending',
      notes: json['notes']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      fulfilledAt: json['fulfilled_at'] != null
          ? DateTime.tryParse(json['fulfilled_at'].toString())
          : null,
    );
  }
}
