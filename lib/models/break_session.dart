class BreakSession {
  final String activityType;
  final int durationMinutes;
  final DateTime timestamp;

  BreakSession({
    required this.activityType,
    required this.durationMinutes,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityType': activityType,
      'durationMinutes': durationMinutes,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory BreakSession.fromMap(Map<String, dynamic> map) {
    return BreakSession(
      activityType: map['activityType'] ?? '',
      durationMinutes: map['durationMinutes']?.toInt() ?? 0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
