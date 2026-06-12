/// Models for the admin dashboard (`DashboardResponse`).

class DashboardStats {
  const DashboardStats({
    required this.totalUsers,
    required this.totalAdmins,
    required this.totalEmployees,
    required this.activeUsers,
    required this.activeStrikes,
    required this.totalStrikes,
    required this.revokedStrikes,
    required this.totalPizzaEvents,
    required this.pendingPizzaEvents,
    required this.fulfilledPizzaEvents,
  });

  final int totalUsers;
  final int totalAdmins;
  final int totalEmployees;
  final int activeUsers;
  final int activeStrikes;
  final int totalStrikes;
  final int revokedStrikes;
  final int totalPizzaEvents;
  final int pendingPizzaEvents;
  final int fulfilledPizzaEvents;

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    int v(String k) => (json[k] as num?)?.toInt() ?? 0;
    return DashboardStats(
      totalUsers: v('total_users'),
      totalAdmins: v('total_admins'),
      totalEmployees: v('total_employees'),
      activeUsers: v('active_users'),
      activeStrikes: v('active_strikes'),
      totalStrikes: v('total_strikes'),
      revokedStrikes: v('revoked_strikes'),
      totalPizzaEvents: v('total_pizza_events'),
      pendingPizzaEvents: v('pending_pizza_events'),
      fulfilledPizzaEvents: v('fulfilled_pizza_events'),
    );
  }
}

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.currentStrikes,
    required this.totalStrikes,
    required this.pizzaParties,
  });

  final int userId;
  final String username;
  final String? fullName;
  final int currentStrikes;
  final int totalStrikes;
  final int pizzaParties;

  String get displayName =>
      (fullName != null && fullName!.trim().isNotEmpty) ? fullName!.trim() : username;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: (json['user_id'] as num).toInt(),
      username: json['username']?.toString() ?? '',
      fullName: json['full_name']?.toString(),
      currentStrikes: (json['current_strikes'] as num?)?.toInt() ?? 0,
      totalStrikes: (json['total_strikes'] as num?)?.toInt() ?? 0,
      pizzaParties: (json['pizza_parties'] as num?)?.toInt() ?? 0,
    );
  }
}

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.type,
    required this.message,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  final String id;
  final String type;
  final String message;
  final int userId;
  final String username;
  final DateTime? timestamp;

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      username: json['username']?.toString() ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'].toString())
          : null,
    );
  }
}

class TrendPoint {
  const TrendPoint({required this.date, required this.count});

  final String date; // YYYY-MM-DD
  final int count;

  factory TrendPoint.fromJson(Map<String, dynamic> json) {
    return TrendPoint(
      date: json['date']?.toString() ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}

class Dashboard {
  const Dashboard({
    required this.stats,
    required this.leaderboard,
    required this.recentActivity,
    required this.trends,
  });

  final DashboardStats stats;
  final List<LeaderboardEntry> leaderboard;
  final List<ActivityItem> recentActivity;
  final List<TrendPoint> trends;

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      leaderboard: (json['leaderboard'] as List<dynamic>? ?? const [])
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recent_activity'] as List<dynamic>? ?? const [])
          .map((e) => ActivityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      trends: (json['trends'] as List<dynamic>? ?? const [])
          .map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
