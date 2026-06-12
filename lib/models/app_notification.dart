/// An in-app notification (`NotificationRead`).
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.strikeId,
    required this.pizzaEventId,
    required this.createdAt,
  });

  final int id;
  final String type; // welcome | strike_added | strike_revoked | pizza_triggered | pizza_fulfilled
  final String title;
  final String message;
  final bool isRead;
  final int? strikeId;
  final int? pizzaEventId;
  final DateTime? createdAt;

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: (json['id'] as num).toInt(),
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      isRead: json['is_read'] as bool? ?? false,
      strikeId: (json['strike_id'] as num?)?.toInt(),
      pizzaEventId: (json['pizza_event_id'] as num?)?.toInt(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
