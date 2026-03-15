class AppStats {
  final int screenTimeMinutes;
  final int burnoutScore;
  final int healthScore;
  final int breakSessionsCompleted;
  final int yesterdayScreenTimeMinutes;

  AppStats({
    required this.screenTimeMinutes,
    required this.burnoutScore,
    required this.healthScore,
    required this.breakSessionsCompleted,
    required this.yesterdayScreenTimeMinutes,
  });

  factory AppStats.empty() {
    return AppStats(
      screenTimeMinutes: 0,
      burnoutScore: 0,
      healthScore: 100,
      breakSessionsCompleted: 0,
      yesterdayScreenTimeMinutes: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'screenTimeMinutes': screenTimeMinutes,
      'burnoutScore': burnoutScore,
      'healthScore': healthScore,
      'breakSessionsCompleted': breakSessionsCompleted,
      'yesterdayScreenTimeMinutes': yesterdayScreenTimeMinutes,
    };
  }

  factory AppStats.fromMap(Map<String, dynamic> map) {
    return AppStats(
      screenTimeMinutes: map['screenTimeMinutes']?.toInt() ?? 0,
      burnoutScore: map['burnoutScore']?.toInt() ?? 0,
      healthScore: map['healthScore']?.toInt() ?? 100,
      breakSessionsCompleted: map['breakSessionsCompleted']?.toInt() ?? 0,
      yesterdayScreenTimeMinutes: map['yesterdayScreenTimeMinutes']?.toInt() ?? 0,
    );
  }
}
